require 'test_helper'

class DateSettingsControllerTest < ActionController::TestCase
  setup do
    @date_setting = date_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:date_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create date_setting" do
    assert_difference('DateSetting.count') do
      post :create, date_setting: { data: @date_setting.data, is_work: @date_setting.is_work, user_id: @date_setting.user_id, year: @date_setting.year }
    end

    assert_redirected_to date_setting_path(assigns(:date_setting))
  end

  test "should show date_setting" do
    get :show, id: @date_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @date_setting
    assert_response :success
  end

  test "should update date_setting" do
    patch :update, id: @date_setting, date_setting: { data: @date_setting.data, is_work: @date_setting.is_work, user_id: @date_setting.user_id, year: @date_setting.year }
    assert_redirected_to date_setting_path(assigns(:date_setting))
  end

  test "should destroy date_setting" do
    assert_difference('DateSetting.count', -1) do
      delete :destroy, id: @date_setting
    end

    assert_redirected_to date_settings_path
  end
end
