require "test_helper"

class DinosaursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dinosaurs_index_url
    assert_response :success
  end

  test "should get new" do
    get dinosaurs_new_url
    assert_response :success
  end

  test "should get edit" do
    get dinosaurs_edit_url
    assert_response :success
  end

  test "should get show" do
    get dinosaurs_show_url
    assert_response :success
  end
end
