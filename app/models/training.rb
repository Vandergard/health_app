class Training < ApplicationRecord
  has_many :training_sets, class_name: "TrainingSet", dependent: :destroy
  accepts_nested_attributes_for :training_sets
end
