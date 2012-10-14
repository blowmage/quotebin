require 'quote_corpus'

module Quotebin
  # Time-limited singleton
  def self.quote_corpus
    return @quote_corpus if @quote_corpus and not @quote_corpus.expired?
    @quote_corpus = QuoteCorpus.new
  end
end
