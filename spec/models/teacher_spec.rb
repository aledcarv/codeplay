require 'rails_helper'

describe Course do
  context 'validation' do
    it 'attributes cannot be blank' do
      teacher = Teacher.new

      teacher.valid?

      expect(teacher.errors[:name]).to include('Cadastre todas as informações')
      expect(teacher.errors[:email]).to include('Cadastre todas as informações')
    end

    it 'code must be uniq' do
      Teacher.create!(name: 'Gonzaga',
                      email: 'gonzaga.profteste@code.com',
                      bio: 'Professor de geografia')

      teacher = Teacher.new(email: 'gonzaga.profteste@code.com')

      teacher.valid?

      expect(teacher.errors[:email]).to include('O email já está em uso')
    end
  end
end