require 'rails_helper'

describe 'admin registers lessons' do
    it 'successfully' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com',)

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on 'Registrar uma aula'

        expect(page).to have_text('Nova aula')

        fill_in 'Nome', with: 'Efeito estufa'
        fill_in 'Conteúdo', with: 'Aula sobre efeito estufa'
        click_on 'Registrar aula'

        expect(current_path).to eq(course_path(course))
        expect(page).to have_content('Efeito estufa')
    end

    it 'and lesson can not be blank' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com',)

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on 'Registrar uma aula'
        click_on 'Registrar aula'

        expect(page).to have_content('não pode ficar em branco', count: 2)
    end
end