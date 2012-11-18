class FieldsController < ApplicationController
  before_filter(:get_event)
  
  # GET /events/1/fields
  # GET /events/1/fields.json
  def index
    @fields = @event.fields.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fields }
    end
  end

  # GET /events/1/fields/1
  # GET /events/1/fields/1.json
  def show
    @field = @event.fields.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @field }
    end
  end

  # GET /events/1/events/1/fields/new
  # GET /events/1/events/1/fields/new.json
  def new
    @field = @event.fields.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :parial => "new", :status => 200 }
    end
  end

  # GET /events/1/fields/1/edit
  def edit
    @field = @event.fields.find(params[:id])
  end

  # POST /events/1/fields
  # POST /events/1/fields.json
  def create
    @field = @event.fields.new(params[:field])

    respond_to do |format|
      if @field.save
        format.html { redirect_to edit_event_path(@event), notice: 'Field was successfully created.' }
        format.json { render json: @field, status: :created, location: [@event,@field] }
      else
        format.html { render action: "new" }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1/fields/1
  # PUT /events/1/fields/1.json
  def update
    @field = @event.fields.find(params[:id])

    respond_to do |format|
      if @field.update_attributes(params[:field])
        format.html { redirect_to edit_event_path(@event), notice: 'Field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1/fields/1
  # DELETE /events/1/fields/1.json
  def destroy
    @field = @event.fields.find(params[:id])
    @field.destroy

    respond_to do |format|
      format.html { redirect_to edit_event_path(@event), notice: 'Feltet ble slettet.' }
      format.json { head :no_content }
    end
  end
end

private
def get_event
    @event = Event.find(params[:event_id])
end