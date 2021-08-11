require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')

    course = Course.create!(name: 'Matemática', description: 'Curso de matemática',
                            code: 'MATCURSO', price: 30,
                            enrollment_deadline: 1.month.from_now, teacher: teacher)

    visit root_path

    expect(page).to have_css('h1', text: 'Codeplay')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
    expect(page).to have_link('Matemática', href: course_path(course))
    expect(page).to have_content('Curso de matemática')
    expect(page).to have_content('R$ 30,00')
  end

  it 'and view details' do
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    Course.create!(name: 'Matemática', description: 'Curso de matemática',
                   code: 'MATCURSO', price: 30,
                   enrollment_deadline: 1.month.from_now, teacher: teacher)

    visit root_path
    click_on 'Matemática'

    expect(page).to have_content('Matemática')
    expect(page).to have_content('Curso de matemática')
    expect(page).to have_content('MATCURSO')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content(1.month.from_now.strftime('%d/%m/%Y'))
  end

  it 'must be signed in to enroll' do
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    Course.create!(name: 'Geografia', description: 'Curso de geografia',
                   code: 'GEOCURSO', price: 30,
                   enrollment_deadline: 1.month.from_now, teacher: teacher)

    visit root_path
    click_on 'Geografia'

    expect(page).to_not have_content('Comprar')
    expect(page).to have_content('Faça login para comprar este curso')
    expect(page).to have_link('login', href: new_student_session_path)
  end

  it 'and view lessons' do
    teacher = Teacher.create!(name: 'Gonzaga',
                              email: 'gonzaga_prof@code.com')
    course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                            code: 'GEOCURSO', price: 30,
                            enrollment_deadline: 1.month.from_now, teacher: teacher)
    Lesson.create!(name: 'Efeito estufa', content: 'Aula sobre efeito estufa', course: course)

    visit root_path
    click_on 'Geografia'

    expect(page).to have_content('Efeito estufa')
    expect(page).to_not have_link('Efeito estufa')
  end
end
