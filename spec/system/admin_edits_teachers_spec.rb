require 'rails_helper'

describe 'admin edits teacher' do
    it 'successfully' do
        teacher1 = Teacher.create!(name: 'Gonzaga', 
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia')

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')

        visit root_path
        click_on 'Professores'
        click_on 'Gonzaga'
        click_on 'Editar'

        fill_in 'Nome', with: 'Cartola'
        fill_in 'Email', with: 'cartola.profteste@code.com'
        fill_in 'Bio', with: 'Professor de história'
        attach_file 'Foto', Rails.root.join('spec/fixtures/teacher-one.jpg')
        click_on 'Editar professor'

        expect(current_path).to eq(teacher_path(teacher1))
        expect(page).to have_content('Cartola')
        expect(page).to have_content('cartola.profteste@code.com')
        expect(page).to have_content('Professor de história')
        expect(page).to have_css('img[src*="teacher-one.jpg"]')
    end

    it 'and attribute can not be blank' do
        teacher1 = Teacher.create!(name: 'Gonzaga', 
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia')

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')

        visit root_path
        click_on 'Professores'
        click_on 'Gonzaga'
        click_on 'Editar'

        fill_in 'Nome', with: ''
        fill_in 'Email', with: ''
        fill_in 'Bio', with: ''
        click_on 'Editar professor'

        expect(page).to have_content('Cadastre todas as informações', count: 2)
    end

    it 'and email must be uniq' do
        teacher1 = Teacher.create!(name: 'Gonzaga',
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia')

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')

        teacher2 = Teacher.create!(name: 'Cartola',
                                   email: 'cartola.profteste@code.com',
                                   bio: 'Professor de história')

        teacher2.profile_picture.attach(io: File.open('spec/fixtures/teacher-one.jpg'),
                                        filename: 'teacher-one.jpg')

        visit root_path
        click_on 'Professores'
        click_on 'Gonzaga'
        click_on 'Editar'

        fill_in 'Email', with: 'cartola.profteste@code.com'
        click_on 'Editar professor'
        
        expect(page).to have_content('O email já está em uso')
    end
end