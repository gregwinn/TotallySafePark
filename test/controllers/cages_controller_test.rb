require "test_helper"

class CagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:user_one)
    @cage = cages(:cage_one)
    sign_in @user
  end

  test "should get index" do
    get cages_path
    assert_response :success
    assert_not_nil assigns(:cages)
  end

  test "should show cage" do
    get cage_path(@cage)
    assert_response :success
  end

  test "should not show non-existent cage" do
    get cage_path(100)
    assert_redirected_to cages_path
    assert_equal "Cage not found.", flash[:alert]
  end

  test "should get new" do
    get new_cage_path
    assert_response :success
  end

  test "should create cage" do
    assert_difference("Cage.count") do
      post cages_path, params: { cage: { name: "New Cage", max_capacity: 10, cage_type: "Herbivore", power: "ACTIVE" } }
    end
    assert_redirected_to cages_path
    assert_equal "Cage was successfully created. Welcome to Jurassic Park!", flash[:notice]
  end

  test "should not create invalid cage" do
    assert_no_difference("Cage.count") do
      post cages_path, params: { cage: { name: nil, max_capacity: nil, cage_type: nil, power: nil } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_cage_path(@cage)
    assert_response :success
  end


  test "should destroy cage" do
    @emptyCage = cages(:cage_without_dinosaurs)
    assert_difference("Cage.count", -1) do
      delete cage_path(@emptyCage)
    end

    assert_redirected_to cages_path
    assert_equal "Cage has been torn down.", flash[:notice]
  end

  test "should not destroy cage with dinosaurs" do
    cage_with_dinosaurs = cages(:cage_with_dinosaurs)
    assert_no_difference("Cage.count") do
      delete cage_path(@cage)
    end
    assert_redirected_to cages_path
    assert_equal "Hey! You have dinosaurs in this cage, you can't let them out!", flash[:alert]
  end
end
