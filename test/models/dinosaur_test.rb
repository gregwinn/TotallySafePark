require "test_helper"

class DinosaurTest < ActiveSupport::TestCase
  test "should save valid dinosaur" do
    cage = cages(:cage_with_space)
    dinosaur = Dinosaur.new(name: "Rexy", species: 0, cage_id: cage.id)
    assert dinosaur.save, "Could not save valid dinosaur"
  end

  test "should not save dinosaur without a name" do
    dinosaur = Dinosaur.new(species: "Tyrannosaurus")
    assert_not dinosaur.save, "Saved dinosaur without a name"
  end

  test "should not save dinosaur without species" do
    dinosaur = Dinosaur.new(name: "Rexy", cage_id: 1)
    assert_not dinosaur.save, "Saved dinosaur without species"
  end

  test "should not save dinosaur with invalid species" do
    dinosaur = Dinosaur.new(name: "Rexy", species: 2, cage_id: 1)
    assert_not dinosaur.save, "Saved dinosaur with invalid species"
  end
end
