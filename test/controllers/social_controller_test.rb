require "minitest_helper"

describe SocialController do
  before do
    @david = users :david
    @mike  = users :mike
    @quote = @mike.quotes.first
    @tag   = tags(:simplicity)
    sign_in @david
  end

  test "should get follow_tag" do
    refute @david.follows?(@tag)
    post :follow_tag, tag: @tag.name
    assert_redirected_to tag_path(@tag.name)
    assert @david.follows?(@tag)
  end

  test "should get follow_username" do
    refute @david.follows?(@mike)
    post :follow_username, username: @mike.username
    assert_redirected_to account_path(@mike.username)
    assert @david.follows?(@mike)
  end

  test "should get like_username_quote" do
    refute @david.likes?(@quote)
    post :like_username_quote, username: @mike.username, id: @quote.id
    assert_redirected_to account_quote_path(@mike.username, @quote.id)
    assert @david.likes?(@quote)
  end
end
