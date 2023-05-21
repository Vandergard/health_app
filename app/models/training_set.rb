class TrainingSet < ApplicationRecord
    # оставьте существующий код модели
    belongs_to :training
    belongs_to :exercise
end