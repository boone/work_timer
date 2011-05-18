require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should belong_to(:project)
  should validate_presence_of(:project)
end
