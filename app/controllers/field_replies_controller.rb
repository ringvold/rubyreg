class FieldRepliesController < ApplicationController
  # GET /field_replies
  # GET /field_replies.json
  def index
    @field_replies = FieldReply.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @field_replies }
    end
  end

  # GET /field_replies/1
  # GET /field_replies/1.json
  def show
    @field_reply = FieldReply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @field_reply }
    end
  end

  # GET /field_replies/new
  # GET /field_replies/new.json
  def new
    @field_reply = FieldReply.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @field_reply }
    end
  end

  # GET /field_replies/1/edit
  def edit
    @field_reply = FieldReply.find(params[:id])
  end

  # POST /field_replies
  # POST /field_replies.json
  def create
    @field_reply = FieldReply.new(params[:field_reply])

    respond_to do |format|
      if @field_reply.save
        format.html { redirect_to @field_reply, notice: 'Field reply was successfully created.' }
        format.json { render json: @field_reply, status: :created, location: @field_reply }
      else
        format.html { render action: "new" }
        format.json { render json: @field_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /field_replies/1
  # PUT /field_replies/1.json
  def update
    @field_reply = FieldReply.find(params[:id])

    respond_to do |format|
      if @field_reply.update_attributes(params[:field_reply])
        format.html { redirect_to @field_reply, notice: 'Field reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @field_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_replies/1
  # DELETE /field_replies/1.json
  def destroy
    @field_reply = FieldReply.find(params[:id])
    @field_reply.destroy

    respond_to do |format|
      format.html { redirect_to field_replies_url }
      format.json { head :no_content }
    end
  end
end
