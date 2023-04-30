class AddTagsToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :tags, :string, array: true, default: []
    add_column :exercises, :equipment, :text
  end
end
