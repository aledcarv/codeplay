require 'rails_helper'

describe 'student view available courses' do
    it 'courses with enrollment still available' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        unavailable_course = Course.create!(name: 'História', description: 'Curso de história',
                                            code: 'HISCURSO', price: 25,
                                            enrollment_deadline: 1.day.ago, teacher: teacher)

        visit root_path

        expect(page).to have_content('Geografia')
        expect(page).to have_content('Curso de geografia')
        expect(page).to have_content('R$ 30,00')
        expect(page).to_not have_content('História')
        expect(page).to_not have_content('Curso de história')
        expect(page).to_not have_content('R$ 25,00')
    end

    it 'and view enrollment link' do
        user = User.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)

        login_as user, scope: :user
        visit root_path
        click_on 'Geografia'

        expect(page).to have_link('Comprar')
    end

    it 'and does not view enrollment if deadline is over' do
        user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        unavailable_course = Course.create!(name: 'Matemática', description: 'Curso de matemática',
                                          code: 'MATCURSO', price: 30,
                                          enrollment_deadline: 1.day.ago, teacher: teacher)

        login_as user, scope: :user
        visit root_path
        click_on 'Cursos'
        click_on 'Matemática'

        expect(page).to_not have_link('Comprar')
        expect(page).to have_content('O prazo de matrícula desse curso encerrou')
    end

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
        expect(page).to have_link('login', href: new_user_session_path)
    end

    it 'and buy a course' do
        user = User.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        other_course = Course.create!(name: 'Sociologia', description: 'Curso de sociologia',
                                      code: 'SOCIOCURSO', price: 25,
                                      enrollment_deadline: 1.month.from_now, teacher: teacher)

        login_as user, scope: :user
        visit root_path
        click_on 'Geografia'
        click_on 'Comprar'

        expect(current_path).to eq(my_enroll_courses_path)
        expect(page).to have_content('Curso comprado com sucesso')
        expect(page).to have_content('Geografia')
        expect(page).to have_content('R$ 30,00')
        expect(page).to_not have_content('Sociologia')
        expect(page).to_not have_content('R$ 25,00')
    end

    it 'and can not buy a course twice' do
        user = User.create!(email: 'jane.doe@code.com', password: '012345')
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.prof@code.com')
        available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                          code: 'GEOCURSO', price: 30,
                                          enrollment_deadline: 1.month.from_now, teacher: teacher)
        Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: available_course)
        Enrollment.create!(user: user, course: available_course)

        login_as user, scope: :user
        visit root_path
        click_on 'Geografia'

        expect(page).to_not have_link('Comprar')
        expect(page).to have_link('Efeito estufa')
    end
end