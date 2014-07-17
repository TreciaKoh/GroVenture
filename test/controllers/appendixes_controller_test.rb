require 'test_helper'

class AppendixesControllerTest < ActionController::TestCase
  setup do
    @appendix = appendixes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appendixes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appendix" do
    assert_difference('Appendix.count') do
      post :create, appendix: {  }
    end

    assert_redirected_to appendix_path(assigns(:appendix))
  end

  test "should show appendix" do
    get :show, id: @appendix
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appendix
    assert_response :success
  end

  test "should update appendix" do
    patch :update, id: @appendix, appendix: {  }
    assert_redirected_to appendix_path(assigns(:appendix))
  end

  test "should destroy appendix" do
    assert_difference('Appendix.count', -1) do
      delete :destroy, id: @appendix
    end

    assert_redirected_to appendixes_path
  end
end
