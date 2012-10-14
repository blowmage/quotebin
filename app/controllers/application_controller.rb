class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :follow_clickstream

  def follow_clickstream
    cs = get_click_stream
    session[:click_stream_id] = cs.id
    if current_user && cs.user_id.nil?
      cs.user_id = current_user.id
      cs.save
      cs.add_click(params,request.env)
    else
      cs.add_click(params,request.env)
    end
  end
  private :follow_clickstream

  def get_click_stream
    if session[:click_stream_id].nil?
      cs = Stream.new(:session_id=>session[:session_id])
      cs.save
    else
      begin
        cs = Stream.find(session[:click_stream_id])
      rescue ActiveRecord::RecordNotFound => e
        cs = Stream.find_by_session_id(session[:session_id])
        cs ||= Stream.new(:session_id=>session[:session_id])
      end
    end
    return cs
  end
  private :get_click_stream

end
