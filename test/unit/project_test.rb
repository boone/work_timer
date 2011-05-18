require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should belong_to(:client)
  should have_many(:events)
  should validate_presence_of(:title)
end
