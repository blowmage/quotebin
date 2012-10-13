class AccountController < ApplicationController
  before_filter :require_account!
  helper_method :account, :quote

  def index; end
  def show_quote; end

  def tag
    @quotes = account.quotes.tagged_with(params[:tag])
    respond_to do |format|
      format.html { render 'quotes/index' }
      format.json { render json: @quotes }
    end
  end

  def tags
    @tags = account.tags
    respond_to do |format|
      format.html { render 'tags/index' }
      format.json { render json: @tags }
    end
  end

  protected

  def account
    @account ||= User.find_by_username params[:username]
  end

  def quote
    @quote ||= account.quotes.find(params[:id])
  end

  def require_account!
    redirect_to root_path unless account
  end

end
