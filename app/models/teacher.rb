class Teacher < ApplicationRecord
    has_one_attached :profile_picture

    validates :name, :email, presence: { message: 'Cadastre todas as informações' }
    validates :email, uniqueness: { message: 'O email já está em uso' }
end
