require "test_helper"

class CageTest < ActiveSupport::TestCase
  test "should not save cage without a name" do
    cage = Cage.new
    assert_not cage.save, "Saved the cage without a name"
  end

  test "should not save cage without max_capacity" do
    cage = Cage.new(name: "Test Cage")
    assert_not cage.save, "Saved the cage without max_capacity"
  end

  test "should not save cage with non-positive max_capacity" do
    cage = Cage.new(name: "Test Cage", max_capacity: 0)
    assert_not cage.save, "Saved the cage with non-positive max_capacity"
  end

  test "should save cage with valid attributes" do
    cage = Cage.new(name: "Test Cage", max_capacity: 10)
    assert cage.save, "Could not save the cage with valid attributes"
  end

  test "should set default cage_type when initialized" do
    cage = Cage.new
    assert_equal "Herbivore", cage.cage_type
  end

  test "should prevent powering off with dinosaurs" do
    cage = cages(:cage_with_dinosaurs)
    cage.power = "DOWN"
    assert_not cage.valid?
  end

  test "should prevent destroying a cage with dinosaurs" do
    cage = cages(:cage_with_dinosaurs)
    assert_not cage.destroy
  end
end
