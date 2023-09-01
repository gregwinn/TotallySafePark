require "test_helper"

class DinosaursControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:user_one)
    @dinosaur = dinosaurs(:dinosaur_one)
    sign_in @user
  end

  test "should get index" do
    get dinosaurs_path
    assert_response :success
    assert_not_nil assigns(:dinosaurs)
  end

  test "should get new" do
    get new_dinosaur_path
    assert_response :success
  end

  test "should create dinosaur" do
    assert_difference("Dinosaur.count") do
      post dinosaurs_path, params: { dinosaur: { name: "Rexy", species: "Tyrannosaurus", cage_id: @dinosaur.cage_id } }
    end

    assert_redirected_to dinosaurs_path
    assert_equal "Roarrr! A new dino has hatched and is now comfortably chilling in its cage.", flash[:notice]
  end

  test "should show dinosaur" do
    get dinosaur_path(@dinosaur)
    assert_response :success
  end

  test "should get edit" do
    get edit_dinosaur_path(@dinosaur)
    assert_response :success
  end

  test "should update dinosaur" do
    patch dinosaur_path(@dinosaur), params: { dinosaur: { name: "Updated Name" } }
    assert_redirected_to dinosaurs_path
    assert_equal "Roarrr! The dino has been hatched... again.", flash[:notice]
  end

  test "should destroy dinosaur" do
    assert_difference("Dinosaur.count", -1) do
      delete dinosaur_path(@dinosaur)
    end

    assert_redirected_to dinosaurs_path
    assert_equal "Well, my dear friend, deleting a dinosaur is like erasing a footnote in history.", flash[:notice]
  end
end
