class ModifyTrainings < ActiveRecord::Migration[7.0]
  def change
    remove_column :trainings, :patient_id, :bigint
    add_column :trainings, :exersise_steps, :string, array: true, default: []
    add_column :trainings, :day_focus, :date
    add_column :trainings, :day, :integer
  end
end
