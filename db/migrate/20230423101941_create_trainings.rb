class CreateTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :trainings do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :difficulty
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
