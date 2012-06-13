require 'test_helper'

class GkconfigsControllerTest < ActionController::TestCase
  setup do
    @gkconfig = gkconfigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gkconfigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gkconfig" do
    assert_difference('Gkconfig.count') do
      post :create, gkconfig: { key: @gkconfig.key, section: @gkconfig.section, value: @gkconfig.value }
    end

    assert_redirected_to gkconfig_path(assigns(:gkconfig))
  end

  test "should show gkconfig" do
    get :show, id: @gkconfig
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gkconfig
    assert_response :success
  end

  test "should update gkconfig" do
    put :update, id: @gkconfig, gkconfig: { key: @gkconfig.key, section: @gkconfig.section, value: @gkconfig.value }
    assert_redirected_to gkconfig_path(assigns(:gkconfig))
  end

  test "should destroy gkconfig" do
    assert_difference('Gkconfig.count', -1) do
      delete :destroy, id: @gkconfig
    end

    assert_redirected_to gkconfigs_path
  end
end
