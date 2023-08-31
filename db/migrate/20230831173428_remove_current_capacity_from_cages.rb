class RemoveCurrentCapacityFromCages < ActiveRecord::Migration[7.0]
  def change
    remove_column :cages, :current_capacity
  end
end
