require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get tele" do
    get :tele
    assert_response :success
  end

  test "should get staff" do
    get :staff
    assert_response :success
  end

  test "should get company" do
    get :company
    assert_response :success
  end

  test "should get overall" do
    get :overall
    assert_response :success
  end

end
