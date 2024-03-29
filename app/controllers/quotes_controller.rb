class QuotesController < ApplicationController
  before_filter :authenticate_user!

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = current_user.quotes.includes(:owner).page(params[:page]).per(20)
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = current_user.quotes.includes(:owner).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/new
  # GET /quotes/new.json
  def new
    @quote = current_user.quotes.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/1/edit
  def edit
    @quote = current_user.quotes.find(params[:id])
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = current_user.quotes.new(params[:quote])

    respond_to do |format|
      if @quote.save
        format.html { redirect_to account_quote_path(username: current_user.username, id: @quote.id), notice: 'Quote was successfully created.' }
        format.json { render json: @quote, status: :created, location: @quote }
      else
        format.html { render action: "new" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    @quote = current_user.quotes.includes(:owner).find(params[:id])

    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        format.html { redirect_to account_quote_path(username: current_user.username, id: @quote.id), notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote = current_user.quotes.includes(:owner).find(params[:id])
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url }
      format.json { head :no_content }
    end
  end
end
