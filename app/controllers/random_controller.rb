class RandomController < ApplicationController
  helper_method :quote

  def index
  end

  protected

  def quote
    Quote.random
  end

end
