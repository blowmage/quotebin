class AccountController < ApplicationController
  before_filter :require_account!
  helper_method :account, :quote

  def index; end
  def quote; end

  protected

  def account
    @accont ||= User.find_by_username params[:username]
  end

  def quote
    @quote ||= account.quotes.find(params[:id])
  end

  def require_account!
    redirect_to root_path unless account
  end
end
