class ReportsController < ApplicationController
  def show
    # determine if the report is for a client or project
    # default to current week or use date from a parameter
    # 7 days or monthly?
    @client = Client.find(params[:client_id])
    @project = @client.projects.find(params[:project_id]) if params[:project_id]

    @projects = @client.projects

    @grouping = params[:grouping] =~ /\A(week|month)\z/ ? params[:grouping] : 'week' # default to week
    
    target_date = Date.parse(params[:date]) rescue nil if params[:date]
    target_date ||= Date.today

    start_time = target_date.to_time.send("beginning_of_#{@grouping}")
    end_time = target_date.to_time.send("end_of_#{@grouping}")

    @start_date = start_time.to_date
    @end_date   = end_time.to_date

    @date_range = @start_date..@end_date

    @next_range = @start_date + 1.send(@grouping)
    @previous_range = @start_date - 1.send(@grouping)
    
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
