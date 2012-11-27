class RepliesController < ApplicationController
  before_filter :require_login, :except => :create

  # GET /replies
  # GET /replies.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    @reply = Reply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.json
  def new
    @event = Event.find(params[:id])
    @form = @event.create_form

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.json
  def create
    @event = Event.find(params[:event_id])
    # @reply = Reply.new(params[:reply])
    @form  = @event.create_form(params[:reply])

    respond_to do |format|
      if @form.valid?
        reply = Reply.create(:event_id => params[:event_id])
        if reply.create_field_replies(params[:reply], params[:field_id])
          format.html { redirect_to confirmation_event_path(@event) }
          format.json { render json: @form, status: :created, location: reply }
        end
      else
        @slug_label = @event.slug_and_label
        format.html { render "events/reply", :locals => { :event => @event, :form => @form} }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    @reply = Reply.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])
    @event = @reply.event
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to replies_event_path(@event) }
      format.json { head :no_content }
    end
  end

  def delete
    # if params[:reply_ids].class.eql? Hash
      params[:reply_ids].each do |reply|
        @reply = Reply.find(reply)
        @event = @reply.event unless @event
        @reply.destroy
      end
    # end

    respond_to do |format|
      format.html { redirect_to replies_event_path(@event), :notice => "Replies deleted" }
      format.json { head :no_content }
    end
  end

end
