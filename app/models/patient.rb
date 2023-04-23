class Patient < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    has_one_attached :photo
end
