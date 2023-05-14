class TotalUpdateTrainings < ActiveRecord::Migration[7.0]
  def change
    remove_column :trainings, :exersise_steps, :string
    remove_column :trainings, :day, :integer
    remove_column :trainings, :day_focus, :date
    add_column :trainings, :sets, :bigint, array: true, default: []
    add_column :trainings, :rests, :integer, array: true, default: []
    add_column :trainings, :counts, :integer, array: true, default: []
    add_column :trainings, :set_configs, :bigint, array: true, default: []
  end
end
