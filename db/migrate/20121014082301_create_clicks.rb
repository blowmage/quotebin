class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.string :action
      t.string :controller
      t.text :params
      t.integer :stream_id
      t.string :path_info
      t.string :request_path
      t.string :request_uri
      t.string :http_user_agent
      t.string :http_referer
      t.string :remote_address

      t.timestamps
    end
  end
end
