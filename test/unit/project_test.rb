require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should belong_to(:client)
  should have_many(:events)
end
