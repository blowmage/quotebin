require 'quote_recommendation_toolkit'

class Quote < ActiveRecord::Base
  include QuoteRecommendationToolkit

  include PgSearch

  belongs_to :owner, class_name: "User"

  acts_as_taggable
  acts_as_likeable

  def likes_count
    self.likers(User).count
  end

  attr_accessible :quotation, :author, :source, :url, :tag_list

  # Tried it with "unaccent" extension, but couldn't figure out the indexes
  pg_search_scope :search,
    against: { quotation: 'A', author: 'B', source: 'B' },
    associated_against: { tags: [:name] },
    using: { tsearch: { prefix: true } }


  def text_source
    "#{quotation} #{author} #{source} #{url}"
  end

  def self.update_popularity
    Quote.find_each { |q| q.popularity = q.likes_count; q.save }
  end

end
