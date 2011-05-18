require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should have_many(:projects)
end
