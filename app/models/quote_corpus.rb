require 'stemmer'

class QuoteCorpus

  attr_reader :expire_at

  # Builds the cached values once
  # Sets an expire_at
  def initialize(expire_at = 1.hour.from_now)
    @expire_at = expire_at
    quote_text
    inverse_document_frequencies
  end

  def expired?
    expire_at < Time.now
  end

  def quote_text
    sql = "select id, concat(quotation, ' ', author, ' ', source, ' ', url) as text from quotes"
    @quote_text ||= Quote.connection.execute(sql).inject({}) do |hash, object|
      terms = terms_from(object["text"])
      hash[object["id"]] = terms
      terms.uniq.each do |term|
        term_document_counts[term] += 1
      end
      hash
    end
  end

  def terms
    @terms ||= quote_text.values.flatten.compact.uniq
  end

  def term_document_counts
    @term_document_counts ||= Hash.new(0)
  end

  def document_count
    @document_count ||= Quote.count
  end

  def inverse_document_frequencies
    @inverse_document_frequencies ||= term_document_counts.inject({}) do |hash, (term, count)|
      hash[term] = count > 0 ? Math.log(document_count / count) : 0
      hash
    end
  end

  def inverse_document_frequency(term)
    inverse_document_frequencies[term.stem].to_f
  end

  def inspect
    "QuoteCorpus: #{expired? ? 'expired' : 'expires: ' + expire_at.to_s} term count: #{terms.size} document count: #{document_count}"
  end

  protected

  def terms_from(text)
    text.to_s.split(/\W+/).map{|term| term.stem.downcase}
  end
end
