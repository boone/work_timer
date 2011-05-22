class Event < ActiveRecord::Base
  belongs_to :project

  default_scope order('start DESC')
  scope :current, where('end IS NULL').order('start DESC')
  scope :completed, where('end IS NOT NULL').order('end DESC')
  
  validates_presence_of :project
  
  def stop!
    if self.end.nil?
      update_attributes(:end => Time.now)
      true
    else
      false
    end
  end
  
  def resume!
    # only allow ended events to be resumed
    if self.end
      new_event = self.clone
      new_event.start = Time.now
      new_event.end = nil
      new_event.save
    else
      false
    end
  end
end
