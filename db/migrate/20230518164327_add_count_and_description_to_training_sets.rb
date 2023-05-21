class AddCountAndDescriptionToTrainingSets < ActiveRecord::Migration[7.0]
  def change
    add_column :training_sets, :count, :int
  end
end
