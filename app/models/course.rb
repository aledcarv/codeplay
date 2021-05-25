class Course < ApplicationRecord
    belongs_to :teacher

    validates :name, :code, :price, presence: true
    validates :code, uniqueness: true
end