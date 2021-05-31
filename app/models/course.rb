class Course < ApplicationRecord
    belongs_to :teacher
    has_many :lessons
    has_many :users, through: :enrollments

    validates :name, :code, :price, presence: true
    validates :code, uniqueness: true
end