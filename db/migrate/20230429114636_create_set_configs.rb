class CreateSetConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :set_configs do |t|
      t.string :name
      t.text :description
      t.integer :weight
      t.integer :time_seconds
      t.integer :distance
      t.integer :speed
      t.integer :incline
      t.integer :pulse
      t.integer :rubber_support
      t.boolean :hypoxia
      t.integer :pauses_count
      t.text :other_details
      t.timestamps
    end
  end
end
