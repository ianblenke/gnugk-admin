require 'test_helper'

class GksectionsControllerTest < ActionController::TestCase
  setup do
    @gksection = gksections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gksections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gksection" do
    assert_difference('Gksection.count') do
      post :create, gksection: { name: @gksection.name }
    end

    assert_redirected_to gksection_path(assigns(:gksection))
  end

  test "should show gksection" do
    get :show, id: @gksection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gksection
    assert_response :success
  end

  test "should update gksection" do
    put :update, id: @gksection, gksection: { name: @gksection.name }
    assert_redirected_to gksection_path(assigns(:gksection))
  end

  test "should destroy gksection" do
    assert_difference('Gksection.count', -1) do
      delete :destroy, id: @gksection
    end

    assert_redirected_to gksections_path
  end
end
