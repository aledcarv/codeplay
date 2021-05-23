class Course < ApplicationRecord
    validates :name, :code, :price, presence: true
    validates :code, uniqueness: true
end