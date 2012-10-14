class AccountController < ApplicationController
  before_filter :require_account!
  helper_method :account, :quotes, :quote

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

  def quotes
    @quotes ||= account.quotes.includes(:owner).page(params[:page]).per(20)
  end

  def quote
    if params[:id]
      @quote ||= account.quotes.includes(:owner).find(params[:id])
    else
      @quote ||= account.quotes.includes(:owner).sample
    end
  end

  def require_account!
    redirect_to root_path unless account
  end

end
