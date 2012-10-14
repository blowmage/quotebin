require 'quote_recommendation_toolkit'

class QuoteBag < Array

  include QuoteRecommendationToolkit

  def initialize(array=nil)
    super()
    Array(array).each do |quote|
      self << quote
    end
  end

  def <<(quote)
    raise ArgumentError, "Can only add a quote" unless quote.is_a?(Quote)
    super
  end

  def []=(index, quote)
    raise ArgumentError, "Can only add a quote" unless quote.is_a?(Quote)
    super
  end

  def tag_list
    map(&:tag_list).flatten.uniq
  end

  def text_source
    map(&:text_source).flatten.join(' ')
  end

end
