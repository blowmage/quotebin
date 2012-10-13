require "minitest_helper"

class TagsControllerTest < MiniTest::Rails::ActionController::TestCase
  before do
    sign_in users(:david)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should get show" do
    get :show
    assert_response :success
    assert_not_nil assigns(:quotes)
  end

end
