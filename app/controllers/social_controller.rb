class SocialController < ApplicationController
  before_filter :authenticate_user!

  def follow_tag
    tag = Tag.find_by_name params[:tag]
    redirect_to root_path if tag.nil?
    current_user.follow! tag

    state = true
    if current_user.follows? tag
      state = false
      current_user.unfollow! tag
    else
      current_user.follow! tag
    end

    respond_to do |format|
      format.html { redirect_to tag_path(tag.name) }
      format.json { render json: { active: true } }
    end
  end

  def follow_username
    user = User.find_by_username params[:username]
    redirect_to root_path if user.nil?
    redirect_to account_path(user.username) if current_user == user

    state = true
    if current_user.follows? user
      state = false
      current_user.unfollow! user
    else
      current_user.follow! user
    end

    respond_to do |format|
      format.html { redirect_to account_path(user.username) }
      format.json { render json: { active: state } }
    end
  end

  def like_username_quote
    user = User.find_by_username params[:username]
    redirect_to root_path if user.nil?
    quote = user.quotes.find_by_id params[:id] # Don't raise here
    redirect_to account_path(user.username) if quote.nil?

    state = true
    if current_user.likes? quote
      state = false
      current_user.unlike! quote
    else
      current_user.like! quote
    end

    respond_to do |format|
      format.html { redirect_to account_quote_path(user.username, quote.id) }
      format.json { render json: { active: state } }
    end
  end
end
