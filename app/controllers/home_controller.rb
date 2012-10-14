class HomeController < ApplicationController
  before_filter :authenticate_user!, only: :profile
  helper_method :quotes

  def index
  end

  def profile
    redirect_to account_path(current_user.username)
  end

  protected

  def quotes
    @quotes ||= Quote.order("RANDOM()").page(params[:page]).per(20)
  end
end
