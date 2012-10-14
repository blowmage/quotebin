require 'stemmer'

module QuoteRecommendationToolkit

  def terms
    @terms ||= text_source.split(/\W+/).map{|term| term.stem.downcase}
  end

  def term_frequencies
    @term_frequencies ||= terms.inject(Hash.new(0)) do |hash, term|
      hash[term] += 1
      hash
    end
  end

  def tf_idf(term)
    term_frequencies[term].to_i * Quotebin.quote_corpus.inverse_document_frequency(term)
  end

  def term_values
    @term_values ||= terms.inject(Hash.new(0.0)) do |hash, term|
      hash[term] = tf_idf(term)
      hash
    end
  end

  def term_distance_from(obj)
    other_hash = obj.respond_to?(:term_values) ? obj.term_values : obj
    all_keys = self.term_values.keys | other_hash.keys
    self_point_array = all_keys.map {|key, value| self.term_values[key].to_f}
    other_point_array = all_keys.map {|key, value| other_hash[key].to_f}
    ruby_pearson(self_point_array, other_point_array)
  end

  def tag_recommendations(quotes, n=3)
    possible_tags = Array(quotes).inject([]) do |array, quote|
      array |= quote.tag_list
      array
    end
    possible_tags -= self.tag_list

    weighted_scores = Hash.new(0.0)
    possible_tags.each do |tag|
      quotes.each do |quote|
        similarity = term_distance_from(quote)
        score = quote.tag_list.include?(tag) ? similarity : 0
        weighted_scores[tag] += score
      end
    end

    quotes_length = quotes.length
    mean_weighted_scores = weighted_scores.inject({}) do |hash, (tag, weighted_score)|
      hash[tag] = weighted_score / quotes_length
      hash
    end

    mean_weighted_scores.sort {|a, b| b[1] <=> a[1] }[0...n]

  end

  private

  def ruby_pearson(x,y)
    n = x.length

    sum_x = x.inject(0) {|r,i| r + i}
    sum_y = y.inject(0) {|r,i| r + i}

    sum_x_squared = x.inject(0) {|r,i| r + i**2}
    sum_y_squared = y.inject(0) {|r,i| r + i**2}

    prods = []; x.each_with_index{|this_x,i| prods << this_x*y[i]}
    p_sum = prods.inject(0){|r,i| r + i}

    # Calculate Pearson score
    num = p_sum-(sum_x*sum_y/n)
    den = ((sum_x_squared-(sum_x**2)/n)*(sum_y_squared-(sum_y**2)/n))**0.5
    if den == 0
      return 0
    end
    r = num/den
    return r
  end

end
