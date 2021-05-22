require 'rails_helper'

describe 'admin view teachers' do
    it 'successfully' do
        teacher1 = Teacher.create!(name: 'Cartola', 
                                   email: 'cartola.profteste@code.com',
                                   bio: 'Professor de história',)

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-one.jpg'), 
                                           filename: 'teacher-one.jpg')

        teacher2 = Teacher.create!(name: 'Gonzaga',
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia')

        teacher2.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')                                      
        
        visit root_path
        click_on 'Professores'

        expect(page).to have_content('Cartola')
        expect(page).to have_content('cartola.profteste@code.com')
        expect(page).to have_content('Professor de história')
        expect(page).to have_css('img[src*="teacher-one.jpg"]')
        expect(page).to have_content('Gonzaga')
        expect(page).to have_content('gonzaga.profteste@code.com')
        expect(page).to have_content('Professor de geografia')
        expect(page).to have_css('img[src*="teacher-two.jpg"]')
    end

    it 'and view details' do
        teacher1 = Teacher.create!(name: 'Cartola',
                                   email: 'cartola.profteste@code.com',
                                   bio: 'Professor de história')

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-one.jpg'),
                                        filename: 'teacher-one.jpg')

        teacher2 = Teacher.create!(name: 'Gonzaga',
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia')

        teacher2.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')

        visit root_path
        click_on 'Professores'
        click_on 'Gonzaga'

        expect(page).to have_content('Gonzaga')
        expect(page).to have_content('gonzaga.profteste@code.com')
        expect(page).to have_content('Professor de geografia')
        expect(page).to have_css('img[src*="teacher-two.jpg"]')
    end

    it 'and no course is available' do
        visit root_path
        click_on 'Professores'

        expect(page).to have_content('Nenhum professor disponível')
    end

    it 'and return to homepage' do
        teacher1 = Teacher.create!(name: 'Cartola',
                                   email: 'cartola.profteste@code.com',
                                   bio: 'Professor de história')

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-one.jpg'),
                                        filename: 'teacher-one.jpg')

        visit root_path
        click_on 'Professores'
        click_on 'Voltar'

        expect(current_path).to eq root_path
    end

    it 'and return to teachers page' do
        teacher1 = Teacher.create!(name: 'Cartola',
                                   email: 'cartola.profteste@code.com',
                                   bio: 'Professor de história')

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-one.jpg'),
                                        filename: 'teacher-one.jpg')

        visit root_path
        click_on 'Professores'
        click_on 'Cartola'
        click_on 'Voltar'

        expect(current_path).to eq teachers_path
    end
end