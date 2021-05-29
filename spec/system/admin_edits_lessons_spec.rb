require 'rails_helper'

describe 'admin edits lesson' do
    it 'successfully' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa', 
                                content: 'Aula sobre efeito estufa',
                                course: course)

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on lesson.name
        click_on 'Editar aula'

        expect(page).to have_text('Editar uma aula')
        
        fill_in 'Nome', with: 'Urbanização'
        fill_in 'Conteúdo', with: 'Aula de urbanização'
        click_on 'Editar'

        expect(page).to have_link('Urbanização', href: course_lesson_path(course, lesson))
    end

    it 'attribute can not be blank' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa', 
                                content: 'Aula sobre efeito estufa',
                                course: course)

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on lesson.name
        click_on 'Editar aula'

        fill_in 'Nome', with: ''
        fill_in 'Conteúdo', with: ''
        click_on 'Editar'

        expect(page).to have_content('não pode ficar em branco', count: 2)
    end
end