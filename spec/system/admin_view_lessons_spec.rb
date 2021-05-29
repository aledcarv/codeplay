require 'rails_helper'

describe 'admin view lessons' do
    it 'of a course' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        Lesson.create!(name: 'Efeito estufa', 
                       content: 'Aula sobre efeito estufa',
                       course: course)

        Lesson.create!(name: 'Urbanização',
                       content: 'Aula sobre urbanização',
                       course: course)

        visit root_path
        click_on 'Cursos'
        click_on course.name

        expect(page).to have_link('Efeito estufa')
        expect(page).to have_link('Urbanização')
    end

    it 'and view content' do
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

        expect(page).to have_content('Efeito estufa')
        expect(page).to have_content('Aula sobre efeito estufa')
    end

    it 'and attribute can not be blank' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        visit root_path
        click_on 'Cursos'
        click_on 'Geografia'

        expect(page).to have_content('Nenhuma aula disponível')
    end

    it 'and return to course page' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa',
                                content: 'Aula de geografia',
                                course: course)

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on lesson.name

        expect(page).to have_link('Voltar', href: course_path(course))
    end
end