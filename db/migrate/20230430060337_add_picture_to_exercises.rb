class AddPictureToExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :picture, :string
  end
end
