require 'test_helper'

# TODO move this block to another helper
require "capybara/rails"
 
module ActionController
  class IntegrationTest
    include Capybara::DSL
  end
end

class MainTest < ActionController::IntegrationTest
  should 'be able to start an event' do
    Factory.create(:project, :title => 'One Project') # form needs a project
    visit '/events'
    click_link 'New Event'
    assert page.has_content?('New Event'), 'checking for New event on page'
    fill_in 'Comment', :with => 'Yo'
    click_button 'Create Event'
    assert page.has_content?('Event was successfully created.'), 'checking for Event was successfully created on page'
    #save_and_open_page
  end
  
  should 'have no existing clients' do
    visit '/clients'
    assert page.has_content?('No existing clients'), 'checking for No existing clients'
  end
  
  should 'not permit a project to be deleted if it has events' do
    event = Factory.create(:event)
    visit client_project_path(event.project.client, event.project)
    assert page.has_no_content?('Delete')
  end

  should 'permit a project to be deleted if it has no events' do
    project = Factory.create(:project)
    visit client_project_path(project.client, project)
    assert page.has_content?('Delete')
  end

  should 'not permit a client to be deleted if it has projects' do
    project = Factory.create(:project)
    visit client_path(project.client)
    assert page.has_no_content?('Delete')
  end

  should 'permit a client to be deleted if it has no projects' do
    client = Factory.create(:client)
    visit client_path(client)
    assert page.has_content?('Delete')
  end
  
  should 'create a new client' do
    client_name = 'Bar Inc.'
    visit clients_path
    click_link 'New'
    fill_in 'Name', :with => client_name
    click_button 'Create Client'
    assert page.has_content?('Client was successfully created.')
    assert page.has_content?(client_name)
  end

  should 'create a new project' do
    project_name = 'Difficult Task'
    client = Factory.create(:client)
    visit client_projects_path(client)
    click_link 'New'
    fill_in 'Title', :with => project_name
    click_button 'Create Project'
    assert page.has_content?('Project was successfully created.')
    assert page.has_content?(project_name)
  end

  should 'create a new event' do
    project = Factory.create(:project)
    visit events_path
    click_link 'New Event'
    fill_in 'Comment', :with => 'Details'
    click_button 'Create Event'
    assert page.has_content?('Event was successfully created.')
    click_link 'Stop'
    assert page.has_content?('Event stopped.')
  end

  should 'only allow one current event' do
    current_event = Factory.create(:event, :end => nil)
    
    visit new_event_path
    fill_in 'Comment', :with => 'Second running event'
    click_button 'Create Event'
    assert page.has_content?('Cannot start a new current event while another is running')
  end

end