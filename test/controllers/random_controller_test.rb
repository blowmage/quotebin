require "minitest_helper"

describe RandomController do
  it "loads successfully" do
    get :index
    assert_response :success
  end
end
