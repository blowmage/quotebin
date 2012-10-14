class AddPopularityToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :popularity, :integer, :default => 0
  end
end
