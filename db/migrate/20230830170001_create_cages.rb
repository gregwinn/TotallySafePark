class CreateCages < ActiveRecord::Migration[7.0]
  def change
    create_table :cages do |t|
        t.string :name
        t.integer :max_capacity
        t.integer :current_capacity, default: 0
        t.integer :cage_type, default: 0
      t.timestamps
    end
  end
end
