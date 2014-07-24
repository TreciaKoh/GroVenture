require 'test_helper'

class HrsControllerTest < ActionController::TestCase
  test "should get takeAttendance" do
    get :takeAttendance
    assert_response :success
  end

  test "should get setWorkingday" do
    get :setWorkingday
    assert_response :success
  end

end
