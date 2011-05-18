require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should have_many(:projects)
  should validate_presence_of(:name)
end
