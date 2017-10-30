require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should have_many(:projects)
  should validate_presence_of(:name)

  should 'not be destroyable if there are projects' do
    project = FactoryBot.create(:project)
    client = project.client
    assert_raise(ActiveRecord::DeleteRestrictionError) { client.destroy }
    assert !client.destroyed?, 'check for !client.destroyed?'
  end
end
