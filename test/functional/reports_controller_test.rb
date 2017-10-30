require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @client = FactoryBot.create(:event).project.client
  end

  test 'should show report' do
    get :show, params: { client_id: @client.id }
    assert_response :success
    assert_not_nil assigns(:start_date)
    assert_not_nil assigns(:end_date)
    assert_not_nil assigns(:date_range)
    assert_not_nil assigns(:next_range)
    assert_not_nil assigns(:previous_range)
    assert_not_nil assigns(:projects)
    assert_not_nil assigns(:grouping)
    assert_not_nil assigns(:report)
  end

  should_eventually 'test project-level reporting'
end
