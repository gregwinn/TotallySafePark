require "test_helper"

class CagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cages_index_url
    assert_response :success
  end

  test "should get new" do
    get cages_new_url
    assert_response :success
  end

  test "should get edit" do
    get cages_edit_url
    assert_response :success
  end
end
