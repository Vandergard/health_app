class RenameSetsToTrainingSets < ActiveRecord::Migration[6.1]
  def change
    rename_table :sets, :training_sets

    # Если у вас есть индексы или внешние ключи, связанные с таблицей sets, переименуйте их здесь.
    # Например, если у вас есть индекс с именем "index_sets_on_exercise_id", переименуйте его:
    # rename_index :training_sets, "index_sets_on_exercise_id", "index_training_sets_on_exercise_id"
  end
end