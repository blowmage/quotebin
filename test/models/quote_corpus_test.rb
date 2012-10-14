require "minitest_helper"

describe QuoteCorpus do
  subject do
    QuoteCorpus.new
  end

  it "takes an optional expire_at parameter" do
    time = Time.now
    subject = QuoteCorpus.new(time)
    subject.expire_at.must_equal time
  end

  it "creates a quote_text hash with quote ids as keys and terms as values" do
    id = Quote.first.id.to_s
    quote_text = subject.quote_text
    assert quote_text.keys.include? id
    value = quote_text[id]
    value.must_include 'einstein'
  end

  it "provides a list of the corpus terms" do
    subject.terms.must_include 'einstein'
  end

  it "shows that term_document_counts can count the number of times a term appears at least once in a document" do
    subject.term_document_counts['einstein'].must_equal 1
  end

  it "stores the number of quotes" do
    subject.document_count.must_equal Quote.count
  end

  it "can lookup the inverse_document_frequency" do
    assert subject.inverse_document_frequency('einstein')
  end

end
