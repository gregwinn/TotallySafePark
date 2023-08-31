class AddPowerStatusToCage < ActiveRecord::Migration[7.0]
  def change
    add_column :cages, :power, :boolean, default: true
  end
end
