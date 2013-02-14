require "minitest_helper"

describe QuotesController do

  before do
    sign_in users(:mike)
    @quote = quotes(:one)
    @attrs = { quotation: "Dependency injection provides vital flexibility in Java and unneeded overhead in Ruby.",
               author:     "Jim Weirich",
               source:     "Dependency Injection in One Sentence",
               url:        "http://onestepback.org/index.cgi/Tech/Ruby/DependencyInjectionInOneSentence.red" }
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:quotes)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Quote.count') do
      post :create, quote: @attrs
    end

    assert_redirected_to account_quote_path(assigns(:quote).owner.username, assigns(:quote))
  end

  def test_show
    get :show, id: @quote.to_param
    assert_response :success
  end

  def test_edit
    get :edit, id: @quote.to_param
    assert_response :success
  end

  def test_update
    put :update, id: @quote.to_param, quote: @attrs
    assert_redirected_to account_quote_path(assigns(:quote).owner.username, assigns(:quote))
  end

  def test_destroy
    assert_difference('Quote.count', -1) do
      delete :destroy, id: @quote.to_param
    end

    assert_redirected_to quotes_path
  end
end
