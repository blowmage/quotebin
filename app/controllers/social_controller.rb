class SocialController < ApplicationController
  before_filter :authenticate_user!

  def follow_tag
    tag = Tag.find_by_name params[:tag]
    redirect_to root_path if tag.nil?
    current_user.follow! tag

    respond_to do |format|
      format.html { redirect_to tag_path(tag.name) }
      format.json { render json: { follow: true } }
    end
  end

  def follow_username
    user = User.find_by_username params[:username]
    redirect_to root_path if user.nil?
    current_user.follow!(user)

    respond_to do |format|
      format.html { redirect_to account_path(user.username) }
      format.json { render json: { follow: true } }
    end
  end

  def like_username_quote
    user = User.find_by_username params[:username]
    redirect_to root_path if user.nil?
    quote = user.quotes.find_by_id params[:id] # Don't raise here
    redirect_to account_path(user.username) if quote.nil?
    current_user.like!(quote)

    respond_to do |format|
      format.html { redirect_to account_quote_path(user.username, quote.id) }
      format.json { render json: { like: true } }
    end
  end
end
