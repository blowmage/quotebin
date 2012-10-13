require "minitest_helper"

class TagsHelperTest < MiniTest::Rails::ActionView::TestCase

  def test_show_tags
    value = show_tags %w(foo bar)
    assert value.to_s.match(%r(tag/foo))
    assert value.to_s.match(%r(tag/bar))
  end

end
