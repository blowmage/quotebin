class TagsController < ApplicationController
  before_filter :require_tag!, only: :show
  helper_method :tags, :tag_name, :tag_object, :quotes

  def index
  end

  def show
  end

  protected

  def tags
    Quote.tag_counts_on(:tags).limit(25)
  end

  def tag_name
    params[:tag]
  end

  def tag_object
    @tag ||= Tag.find_by_name(tag_name)
  end

  def quotes
    @quotes ||= Quote.tagged_with(tag_name)
  end

  def require_tag!
    redirect_to root_path if tag_object.nil?
  end
end
