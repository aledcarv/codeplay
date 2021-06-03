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

        user_login
        visit admin_course_path(course)

        expect(page).to have_link('Efeito estufa')
        expect(page).to have_link('Urbanização')
    end

    it 'and view content' do
        user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')        

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: 30.days.from_now, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa',
                                content: 'Aula sobre efeito estufa',
                                course: course)

        login_as user, scope: :user

        visit admin_course_path(course)
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

        user_login
        visit admin_course_path(course)

        expect(page).to have_content('Nenhuma aula disponível')
    end

    it 'and return to course page' do
        user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa',
                                content: 'Aula de geografia',
                                course: course)

        login_as user, scope: :user

        visit admin_course_lesson_path(course, lesson)

        expect(page).to have_link('Voltar', href: admin_course_path(course))
    end

    it 'and must be logged in to access id route' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa',
                                content: 'Aula de geografia',
                                course: course)

        visit admin_course_lesson_path(course, lesson)

        expect(current_path).to eq(new_user_session_path)
    end
end