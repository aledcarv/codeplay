class Teacher < ApplicationRecord
    validates :name, :email, presence: { message: 'Cadastre todas as informações' }
    validates :email, uniqueness: { message: 'O email já está em uso' }

    has_one_attached :profile_picture

    before_create :attach_default_profile_picture

    def attach_default_profile_picture
        return if profile_picture.attached?
            profile_picture.attach(io: File.open('spec/fixtures/default.png'),
                                   filename: 'default.png')
    end
end
