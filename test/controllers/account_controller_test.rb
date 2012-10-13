require "minitest_helper"

describe AccountController do

  it "should get index" do
    get :index, username: users(:mike).username
    assert_response :success
  end

  it "should get quote" do
    get :index, username: users(:mike).username, id: users(:mike).quotes.first.id
    assert_response :success
  end
end
