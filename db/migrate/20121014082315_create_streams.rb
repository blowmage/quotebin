class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :session_id
      t.integer :user_id
      t.integer :child_stream_id

      t.timestamps
    end
  end
end
