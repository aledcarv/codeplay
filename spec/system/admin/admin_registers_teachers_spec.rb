require 'rails_helper'

describe 'admin register teacher' do
  it 'Successfully' do
    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'

    fill_in 'Nome', with: 'Gonzaga'
    fill_in 'Email', with: 'gonzaga.profteste@code.com'
    fill_in 'Bio', with: 'Professor de geografia'
    attach_file 'Foto de perfil', Rails.root.join('spec/fixtures/teacher-two.jpg')
    click_on 'Criar professor'

    expect(current_path).to eq(admin_teacher_path(Teacher.last))
    expect(page).to have_content('Gonzaga')
    expect(page).to have_content('gonzaga.profteste@code.com')
    expect(page).to have_content('Professor de geografia')
    expect(page).to have_css('img[src*="teacher-two.jpg"]')
  end

  it 'and attributes can not be blank' do
    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'

    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'Bio', with: ''
    click_on 'Criar professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be uniq' do
    teacher1 = Teacher.create!(name: 'Gonzaga',
                               email: 'gonzaga.profteste@code.com',
                               bio: 'Professor de geografia')

    teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                    filename: 'teacher-two.jpg')

    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'

    fill_in 'Email', with: 'gonzaga.profteste@code.com'
    click_on 'Criar professor'

    expect(page).to have_content('já está em uso')
  end

  it 'and must be logged in to access route' do
    visit new_admin_teacher_path

    expect(current_path).to eq(new_user_session_path)
  end
end
