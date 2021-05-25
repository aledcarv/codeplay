class Teacher < ApplicationRecord
    has_many :courses

    validates :name, :email, presence: true
    validates :email, uniqueness: true

    has_one_attached :profile_picture

    before_create :attach_default_profile_picture

    def attach_default_profile_picture
        return if profile_picture.attached?
            profile_picture.attach(io: File.open('spec/fixtures/default.png'),
                                   filename: 'default.png')
    end

    def display_name
        "#{name} - #{email}"
    end
end
