class Course < ApplicationRecord
    belongs_to :teacher
    has_many :lessons
    has_many :users, through: :enrollments
    has_many :students, through: :enrollments

    validates :name, :code, :price, presence: true
    validates :code, uniqueness: true

    scope :available, -> { where(enrollment_deadline: Date.current..) }
    scope :min_to_max, -> { order(price: :asc) }
end