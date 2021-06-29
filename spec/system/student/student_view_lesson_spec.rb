require 'rails_helper'

describe 'student view lesson' do
    it 'successfully' do
        student = Student.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga_prof@code.com')
        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        lesson =  Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)
        Enrollment.create!(student: student, course: course, price: course.price)

        login_as student, scope: :student

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on lesson.name

        expect(page).to have_content('Efeito estufa')
        expect(page).to have_content('Aula sobre efeito estufa')
        
    end

    it 'without enrollment can not view lesson link' do
        student = Student.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga_prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: available_course)
    
        login_as student, scope: :student
    
        visit root_path
        click_on 'Cursos'
        click_on 'Geografia'
    
        expect(page).to_not have_link('Efeito estufa')
        expect(page).to have_content('Efeito estufa')
    end
    
    it 'without login can not view lesson' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga_prof@code.com')
        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        lesson = Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)
    
        visit student_course_lesson_path(course, lesson)
    
        expect(current_path).to eq(new_student_session_path)
    end
    
    it 'without enrollment can not view lesson' do
        student = Student.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga_prof@code.com')
        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        lesson = Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)
    
        login_as student, scope: :student
        visit student_course_lesson_path(course, lesson)
    
        expect(current_path).to eq(student_course_path(course))
        expect(page).to have_link('Comprar')
    end
end