class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @quotes = current_user.quotes.tagged_with(params[:tag])
    respond_to do |format|
      format.html { render 'quotes/index' }
      format.json { render json: @quotes }
    end
  end
end
