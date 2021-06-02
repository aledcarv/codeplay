require 'rails_helper'

describe 'admin deletes lesson' do
    it 'delete' do
        user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                code: 'GEOCURSO', price: 25,
                                enrollment_deadline: Time.current, teacher: teacher)

        lesson = Lesson.create!(name: 'Efeito estufa', 
                                content: 'Aula sobre efeito estufa',
                                course: course)

        login_as user, scope: :user

        visit admin_course_lesson_path(course, lesson)

        expect { click_on 'Apagar' }.to change { Lesson.count }.by(-1)

        expect(current_path).to eq(admin_course_path(course))
    end
end