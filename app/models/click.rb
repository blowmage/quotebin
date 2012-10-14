require 'json'

class Click < ActiveRecord::Base

  belongs_to :stream

  attr_accessible :action, :controller, :http_referer, :http_user_agent, :params, :path_info, :remote_address, :request_path, :request_uri, :stream_id

  def params
    found = read_attribute(:params)
    begin
      JSON(found)
    rescue
      found
    end
  end

  def params=(value)
    write_attribute(:params, JSON.dump(value))
  end
end
