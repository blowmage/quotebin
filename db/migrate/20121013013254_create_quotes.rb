class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :owner_id
      t.text :quotation
      t.string :author
      t.string :source
      t.string :url

      t.timestamps
    end
  end
end
