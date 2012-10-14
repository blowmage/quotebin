class HomeController < ApplicationController
  before_filter :authenticate_user!, only: :profile
  helper_method :quotes

  def index
  end

  def recent
    @quotes = Quote.includes(:owner).order("quotes.created_at DESC").page(params[:page]).per(20)
    render :index
  end

  def profile
    redirect_to account_path(current_user.username)
  end

  protected

  def quotes
    @quotes ||= Quote.includes(:owner).order("quotes.popularity DESC, quotes.id ASC").page(params[:page]).per(20)
  end
end
