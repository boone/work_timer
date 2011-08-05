class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    @completed_events = Event.completed.page(params[:page]).per(15)

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(events_url, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url, :notice => 'Event was deleted.') }
      format.xml  { head :ok }
    end
  end
  
  # stop an event
  def stop
    @event = Event.find(params[:id])
    if @event.stop!
      respond_to do |format|
        format.html { redirect_to(events_url, :notice => 'Event stopped.') }
        #format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to(events_url, :notice => 'Event was already stopped.') }
        #format.xml  { head :ok }
      end
    end
  end
  
  # copy existing event and start
  def resume
    @event = Event.find(params[:id])
    if @event.resume!
      respond_to do |format|
        format.html { redirect_to(events_url, :notice => 'Event resumed.') }
        #format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to(events_url, :notice => 'Unable to resume event. Is another event currently running?') }
        #format.xml  { head :ok }
      end
    end
  end
  
  def current
    current_events = Event.current
    render :partial => 'events/current', :current_events => current_events
  end
end
