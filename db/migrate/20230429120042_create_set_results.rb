class CreateSetResults < ActiveRecord::Migration[7.0]
  def change
    create_table :set_results do |t|
      t.string :set_comp_code
      t.references :patients, null: false, foreign_key: true
      t.references :trainings, null: false, foreign_key: true
      t.references :set_configs, null: false, foreign_key: true
      t.text :self_perception
      t.text :assesment
      t.timestamps
    end
  end
end
