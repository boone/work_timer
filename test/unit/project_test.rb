require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should belong_to(:client)
  should have_many(:events)
  should validate_presence_of(:title)

  should 'not be destroyable if there are events' do
    event = FactoryBot.create(:event)
    project = event.project
    assert_raise(ActiveRecord::DeleteRestrictionError) { project.destroy }
    assert !project.destroyed?, 'check for !project.destroyed?'
  end
end
