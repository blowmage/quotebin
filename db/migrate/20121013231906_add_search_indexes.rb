class AddSearchIndexes < ActiveRecord::Migration
  def up
    execute "CREATE INDEX quotes_quotation_search_index " +
      "ON quotes " +
      "USING gin(to_tsvector('english', coalesce(\"quotation\"::text, '')));"
    execute "CREATE INDEX quotes_author_search_index " +
      "ON quotes " +
      "USING gin(to_tsvector('english', coalesce(\"author\"::text)));"
  end

  def down
    execute "DROP INDEX quotes_quotation_search_index;"
    execute "DROP INDEX quotes_author_search_index;"
  end
end
