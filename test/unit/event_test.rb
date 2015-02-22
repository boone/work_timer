require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should belong_to(:project)
  should validate_presence_of(:project)
  should validate_presence_of(:start)
  
  should 'allow start time before end time' do
    event = FactoryGirl.build(:event, start: 1.hour.ago, end: Time.now)
    assert event.valid?
  end
  
  should 'not allow start time after end time' do
    event = FactoryGirl.build(:event, end: 1.hour.ago, start: Time.now)
    assert !event.valid?
    assert event.errors[:end]
  end
  
  should 'not allow multiple current events' do
    current_event = FactoryGirl.build(:event, end: nil)
    event = Event.new(start: Time.now, comment: 'Second event')
    assert !event.valid?
    assert event.errors[:base]
  end
  
  should 'compute zero for daily time when there are no events today' do
    FactoryGirl.create(:event, start: 1.day.ago.beginning_of_day, end: 1.day.ago.beginning_of_day + 1.hour) # yesterday
    assert_equal 0, Event.time_today
  end
  
  should 'compute correct daily time when there is no current event' do
    FactoryGirl.create(:event, start: 1.day.ago.beginning_of_day, end: 1.day.ago.beginning_of_day + 1.hour) # yesterday
    FactoryGirl.create(:event, start: Time.now.beginning_of_day, end: Time.now.beginning_of_day + 1.hour) # 1 hour
    FactoryGirl.create(:event, start: Time.now.beginning_of_day + 2.hours, end: Time.now.beginning_of_day + 3.hours) # 1.hour
    assert_equal 2, Event.today.count
    assert_equal 2.hours, Event.time_today
  end

  should 'compute correct daily time when there is a current event' do
    FactoryGirl.create(:event, start: 1.day.ago.beginning_of_day, end: 1.day.ago.beginning_of_day + 1.hour) # yesterday
    FactoryGirl.create(:event, start: Time.now.beginning_of_day, end: Time.now.beginning_of_day + 1.hour) # 1 hour
    FactoryGirl.create(:event, start: Time.now.beginning_of_day, end: nil)

    assert_equal 2, Event.today.count
    
    # Time.now calls at different stages will not be exact, so assert the results are the same to thousandths of an hour
    expected_time = ((1.hour + (Time.now - Time.now.beginning_of_day)) / 3.6).to_i
    actual_time = (Event.time_today / 3.6).to_i
    assert_equal expected_time, actual_time
  end
  
  should 'be able to resume a completed event' do
    original_event      = FactoryGirl.create(:event)
    original_start_time = original_event.start.to_i # typecast to avoid nanosecond comparions
    original_end_time   = original_event.end.to_i   # typecast to avoid nanosecond comparions
    assert_equal 1, Event.count
    
    original_event.resume!
    original_event.reload

    # test that the original event's times have not been modified
    assert_equal original_start_time, original_event.start.to_i
    assert_equal original_end_time, original_event.end.to_i
    
    # test that the original event and the new event are present
    assert_equal 2, Event.count
  end
end
