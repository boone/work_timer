class ReportsController < ApplicationController
  def show
    # determine if the report is for a client or project
    # default to current week or use date from a parameter
    # 7 days or monthly?
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:project_id]) if params[:project_id]

    @projects = @client.projects

    start_time = 1.hour.ago.beginning_of_week #Time.now.beginning_of_week
    end_time = 1.hour.ago.end_of_week #Time.now.beginning_of_week
    #end_time   = Time.now.end_of_week

    @start_date = start_time.to_date
    @end_date   = end_time.to_date

    @date_range = @start_date..@end_date
    
    @report = {}
    
    if @project
      # just the events for that project
      # TODO
    else
      @report['totals'] ||= {}

      @projects.each do |project|
        events = project.events.completed.where('start BETWEEN ? AND ?', start_time, end_time)
        
        events.each do |event|
          @report[project.id] ||= {}

          if !@report[project.id]["#{event.start.to_date}"]
            @report[project.id]["#{event.start.to_date}"] = event.end - event.start
          else
            @report[project.id]["#{event.start.to_date}"] += event.end - event.start
          end
          
          if !@report['totals']["#{event.start.to_date}"]
            @report['totals']["#{event.start.to_date}"] = event.end - event.start
          else
            @report['totals']["#{event.start.to_date}"] += event.end - event.start
          end
        end
      end
    end


    # # get events for client (or project if it is defined)
    # @events = (@project || @client).events.where('start BETWEEN ? AND ?', start_time, end_time)
    # 
    # # client level report
    # # date, project, total for project
    # 
    # # project level report
    # # date, total for project
    # 
    # date_range = start_time.to_date..end_time.to_date
    # 
    # @report = {}
    # 
    # @events.each do |event|
    #   if @report[:]
    # end
    
  end
end
