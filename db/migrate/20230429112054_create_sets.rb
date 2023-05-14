class CreateSets < ActiveRecord::Migration[7.0]
  def change
    create_table :sets do |t|
      t.string :name
      t.text :description
      t.references :exercise, null: false, foreign_key: true
      t.integer :reps
      t.integer :duration
      t.integer :set_rest
      t.timestamps
    end
  end
end
