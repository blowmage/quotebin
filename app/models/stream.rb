class Stream < ActiveRecord::Base
  belongs_to :user
  belongs_to :child, :foreign_key => :child_stream_id, :class_name => "Stream"
  has_one :parent, :foreign_key => :child_stream_id, :class_name => "Stream"
  has_many :clicks, :dependent => :destroy

  scope :since, ->(time) {includes([:clicks, :user]).where("streams.created_at >?", time).order("streams.created_at DESC")}

  attr_accessible :child_stream_id, :session_id, :user_id

  def add_click(params, env)
    click = Click.new(
      :action=>params[:action], :controller=>params[:controller], :path_info=>env["PATH_INFO"], :params=>params,
      :request_path=>env["REQUEST_PATH"], :request_uri=>env["REQUEST_URI"], :http_user_agent=>env["HTTP_USER_AGENT"],
      :http_referer=>env["HTTP_REFERER"], :remote_address=>env["REMOTE_ADDR"]
    )
    self.clicks << click
    click.save
  end

  # When someone logs in, their previous session is linked to the new session.
  # TODO: Maybe session logouts or more session linking will have to be imposed,
  # I'll know when I start to analyze click stream data.
  def add_child_stream(stream)
    update_attribute(:child_stream_id, stream.id)
  end

  def first_linked_stream
    parents = []
    child = self
    while parent = child.parent
      parents << parent
      child = parent
    end
    parents.empty? ? self : parents.last
  end

  def last_linked_stream
    children = []
    parent = self
    while child = parent.child
      children << child
      parent = child
    end
    children.empty? ? self : children.last
  end

  def duration
    first_stream = first_linked_stream
    first_click = first_stream.clicks.empty? ? first_stream.created_at : first_stream.clicks.first.created_at

    last_stream = last_linked_stream
    last_click = last_stream.clicks.empty? ? last_stream.created_at : last_stream.clicks.last.created_at

    last_click - first_click
  end
end
