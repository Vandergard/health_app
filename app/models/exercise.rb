class Exercise < ApplicationRecord
    has_one_attached :picture
    has_many :training_sets
end