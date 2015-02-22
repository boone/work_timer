require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = FactoryGirl.create(:project)
  end

  test "should get index" do
    get :index, client_id: @project.client
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new, client_id: @project.client
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should create project" do
    new_project = FactoryGirl.build(:project, title: 'New Project')
    assert_difference('Project.count') do
      post :create, client_id: new_project.client, project: new_project.attributes
    end

    assert_redirected_to client_projects_url(new_project.client)
  end

  test "should show project" do
    get :show, client_id: @project.client, id: @project.to_param
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get edit" do
    get :edit, client_id: @project.client, id: @project.to_param
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should update project" do
    put :update, client_id: @project.client, id: @project.to_param, project: @project.attributes
    assert_redirected_to client_project_url(@project.client, @project)
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, client_id: @project.client, id: @project.to_param
    end

    assert_redirected_to client_projects_url(@project.client)
  end
end
