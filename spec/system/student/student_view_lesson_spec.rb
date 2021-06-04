require 'rails_helper'

describe 'student view lesson' do
    it 'successfully' do
        user = User.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        lesson =  Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)
        Enrollment.create!(user: user, course: course, price: course.price)

        login_as user, scope: :user

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on lesson.name

        expect(page).to have_content('Efeito estufa')
        expect(page).to have_content('Aula sobre efeito estufa')
        
    end

    it 'without enrollment can not view lesson link' do
        user = User.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: available_course)
    
        login_as user, scope: :user
    
        visit root_path
        click_on 'Cursos'
        click_on 'Geografia'
    
        expect(page).to_not have_link('Efeito estufa')
        expect(page).to have_content('Efeito estufa')
    end
    
    it 'without login can not view lesson' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        lesson = Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)
    
        visit course_lesson_path(course, lesson)
    
        expect(current_path).to eq(new_user_session_path)
    end
    
    it 'without enrollment can not view lesson' do
        user = User.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        lesson = Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)
    
        login_as user, scope: :user
        visit course_lesson_path(course, lesson)
    
        expect(current_path).to eq(course_path(course))
        expect(page).to have_link('Comprar')
    end
end