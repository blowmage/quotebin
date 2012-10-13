# encoding: UTF-8
require "minitest_helper"

describe User, :username do

  before do
    @mike = users :mike
  end

  it "finds users by their case insensitive username" do
    @mike.username = "BLOWMAGE"
    @mike.save!
    assert_equal User.find_by_username("blowmage"), @mike

    @mike.username = "blowmage"
    @mike.save!
    assert_equal User.find_by_username("BLOWMAGE"), @mike

    @mike.username = "Bl0wM4g3"
    @mike.save!
    assert_equal User.find_by_username("bl0wm4g3"), @mike

    @mike.username = "123456"
    @mike.save!
    assert_equal User.find_by_username("123456"), @mike
  end

end
