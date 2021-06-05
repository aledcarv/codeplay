require 'rails_helper'

describe 'visitor view available courses' do
    it 'must be signed in to enroll' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)

        visit root_path
        click_on 'Geografia'

        expect(page).to_not have_content('Comprar')
        expect(page).to have_content('Faça login para comprar este curso')
        expect(page).to have_link('login', href: new_student_session_path)
    end
end