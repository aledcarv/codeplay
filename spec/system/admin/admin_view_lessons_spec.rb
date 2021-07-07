require 'rails_helper'

describe 'admin view lessons' do
  it 'of a course' do
    course = create(:course)
    create(:lesson, name: 'Efeito estufa', course: course)
    create(:lesson, name: 'Urbanização', course: course)

    user_login
    visit admin_course_path(course)

    expect(page).to have_link('Efeito estufa')
    expect(page).to have_link('Urbanização')
  end

  it 'and view content' do
    user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')

    course = create(:course)
    lesson = create(:lesson, course: course)

    login_as user, scope: :user

    visit admin_course_path(course)
    click_on lesson.name

    expect(page).to have_content('Efeito estufa')
    expect(page).to have_content('Aula sobre efeito estufa')
  end

  it 'and attribute can not be blank' do
    course = create(:course)

    user_login
    visit admin_course_path(course)

    expect(page).to have_content('Nenhuma aula disponível')
  end

  it 'and return to course page' do
    user = User.create!(email: 'pessoa.cadastro@code.com', password: '012345')
    course = create(:course)
    lesson = create(:lesson, course: course)

    login_as user, scope: :user

    visit admin_course_lesson_path(course, lesson)

    expect(page).to have_link('Voltar', href: admin_course_path(course))
  end

  it 'and must be logged in to access id route' do
    course = create(:course)

    lesson = create(:lesson, course: course)

    visit admin_course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end
end
