require 'rails_helper'

describe 'admin deletes lesson' do
    it 'delete' do
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

        expect { click_on 'Apagar' }.to change { Lesson.count }.by(-1)

        expect(current_path).to eq(course_path(course))
    end
end