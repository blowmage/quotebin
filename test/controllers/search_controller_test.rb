require "minitest_helper"

class SearchControllerTest < MiniTest::Rails::ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

end
