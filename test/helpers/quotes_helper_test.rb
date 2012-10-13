require "minitest_helper"

describe QuotesHelper do
  def test_sanity
    assert QuotesHelper
  end

  def test_markdown
    input = "*test*"
    output = markdown(input)
    assert output.include? "<p><em>test</em></p>"
  end

  def test_markdown_avoids_xss_attacks
    input = "<script>alert('I steal cookies!')</script>"
    output = markdown(input)
    refute output.include?("script"), "The markdown parser does not allow script tags"
    assert output.include?("steal"), "The markdown does include safe content"
  end

end
