require "minitest_helper"

describe Quote do

  subject do
    quotes(:one)
  end

  it "provides text_source" do
    assert subject.text_source.include?("Albert")
    assert subject.text_source.include?("intelligent fool")
    assert subject.text_source.include?("zeitgeist")
    assert subject.text_source.include?("example.com")
  end

  it "stems the text_source for terms" do
    assert subject.terms.include?("albert")
    assert subject.terms.include?("intellig")
    assert subject.terms.include?("zeitgeist")
    assert subject.terms.include?("exampl")
  end

  it "produces decent term_frequencies" do
    frequencies = subject.term_frequencies
    frequencies['bigger'].must_equal(1)
    frequencies['not_found'].must_equal 0
  end

  it "stores the tf_idf in the term_values (term frequency inverse document frequency, it's a statistic)" do
    subject.term_values['einstein'].must_equal subject.tf_idf('einstein')
  end

  it "doesn't complain in tf_idf for a term that doesn't exist" do
    subject.tf_idf('oppenheimer').must_equal 0
    subject.term_values['oppenheimer'].must_equal 0
  end

  it "can find the pearson correlation for two quotes" do
    another_quote = quotes(:two)
    distance = subject.term_distance_from(another_quote)
    assert distance
  end

  it "can find the pearson correlation for a quote and a terms value hash" do
    term_values = subject.term_values
    subject.term_distance_from(term_values).must_equal 1.0
    linear_offest = term_values.inject({}) do |hash, (key, value)|
      hash[key] = value + 3
      hash
    end
    subject.term_distance_from(linear_offest).must_be_close_to 1.0, 0.01
  end

end
