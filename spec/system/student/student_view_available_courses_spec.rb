require 'rails_helper'

describe 'student view available courses' do
  it 'courses with enrollment still available' do
    student = Student.create!(email: 'jane.doe@code.com', password: '012345')
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    Course.create!(name: 'Geografia', description: 'Curso de geografia',
                   code: 'GEOCURSO', price: 30,
                   enrollment_deadline: 1.month.from_now, teacher: teacher)
    Course.create!(name: 'História', description: 'Curso de história',
                   code: 'HISCURSO', price: 25,
                   enrollment_deadline: 1.day.ago, teacher: teacher)

    login_as student, scope: :student
    visit root_path

    expect(page).to have_content('Geografia')
    expect(page).to have_content('Curso de geografia')
    expect(page).to have_content('R$ 30,00')
    expect(page).to_not have_content('História')
    expect(page).to_not have_content('Curso de história')
    expect(page).to_not have_content('R$ 25,00')
  end

  it 'and view enrollment link' do
    student = Student.create!(email: 'jane.doe@code.com', password: '012345')
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    Course.create!(name: 'Geografia', description: 'Curso de geografia',
                   code: 'GEOCURSO', price: 30,
                   enrollment_deadline: 1.month.from_now, teacher: teacher)

    login_as student, scope: :student
    visit root_path
    click_on 'Geografia'

    expect(page).to have_link('Comprar')
  end

  it 'and does not view enrollment if deadline is over' do
    student = Student.create!(email: 'pessoa.cadastro@code.com', password: '012345')
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    Course.create!(name: 'Matemática', description: 'Curso de matemática',
                   code: 'MATCURSO', price: 30,
                   enrollment_deadline: 1.day.ago, teacher: teacher)

    login_as student, scope: :student
    visit root_path
    click_on 'Cursos'
    click_on 'Matemática'

    expect(page).to_not have_link('Comprar')
    expect(page).to have_content('O prazo de matrícula desse curso encerrou')
  end

  it 'and buy a course' do
    student = Student.create!(email: 'jane.doe@code.com', password: '012345')
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    Course.create!(name: 'Geografia', description: 'Curso de geografia',
                   code: 'GEOCURSO', price: 30,
                   enrollment_deadline: 1.month.from_now, teacher: teacher)
    Course.create!(name: 'Sociologia', description: 'Curso de sociologia',
                   code: 'SOCIOCURSO', price: 25,
                   enrollment_deadline: 1.month.from_now, teacher: teacher)

    login_as student, scope: :student
    visit root_path
    click_on 'Geografia'
    click_on 'Comprar'

    expect(current_path).to eq(my_enroll_student_courses_path)
    expect(page).to have_content('Curso comprado com sucesso')
    expect(page).to have_content('Geografia')
    expect(page).to have_content('R$ 30,00')
    expect(page).to_not have_content('Sociologia')
    expect(page).to_not have_content('R$ 25,00')
  end

  it 'and can not buy a course twice' do
    student = Student.create!(email: 'jane.doe@code.com', password: '012345')
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    available_course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                      code: 'GEOCURSO', price: 30,
                                      enrollment_deadline: 1.month.from_now, teacher: teacher)
    Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: available_course)
    Enrollment.create!(student: student, course: available_course)

    login_as student, scope: :student
    visit root_path
    click_on 'Geografia'

    expect(page).to_not have_link('Comprar')
    expect(page).to have_link('Efeito estufa')
  end
end
