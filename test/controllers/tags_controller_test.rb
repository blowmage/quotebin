require "minitest_helper"

describe TagsController do
  it "should get index" do
    get :index
    assert_response :success
  end

  it "should get show" do
    get :show, tag: "design"
    assert_response :success
  end
end
