require 'rails_helper'

describe 'admin edits courses' do
    it 'succesfully' do
        course = Course.create!(name: 'Ruby',
                       description: 'Um curso de Ruby',
                       code: 'RUBYBASIC',
                       price: '10',
                       enrollment_deadline: '22/12/2033')
        
        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on 'Editar'

        fill_in 'Nome', with: 'Ruby on Rails'
        fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
        fill_in 'Código', with: 'RUBYONRAILS'
        fill_in 'Preço', with: '30'
        fill_in 'Data limite de matrícula', with: '24/10/2034'
        click_on 'Editar curso'

        expect(page).to have_content('Ruby on Rails')
        expect(page).to have_content('Um curso de Ruby on Rails')
        expect(page).to have_content('RUBYONRAILS')
        expect(page).to have_content('30')
        expect(page).to have_content('24/10/2034')
    end

    it 'and attribute can not be blank' do
        course = Course.create!(name: 'Ruby',
                                description: 'Um curso de Ruby',
                                code: 'RUBYBASIC',
                                price: '10',
                                enrollment_deadline: '22/12/2033')

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on 'Editar'

        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Código', with: ''
        fill_in 'Preço', with: ''
        fill_in 'Data limite de matrícula', with: ''
        click_on 'Editar curso'

        expect(page).to have_content('não pode ficar em branco', count: 3)
    end

    it 'and attribute must be unique' do
        course = Course.create!(name: 'Ruby',
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC',
                              price: '10',
                              enrollment_deadline: '22/12/2033')

        another_course = Course.create!(name: 'Ruby on Rails',
                                        description: 'Um curso de Ruby on Rails',
                                        code: 'RUBYONRAILS',
                                        price: '30',
                                        enrollment_deadline: '24/10/2034')

        visit root_path
        click_on 'Cursos'
        click_on course.name
        click_on 'Editar'

        fill_in 'Código', with: 'RUBYONRAILS'
        click_on 'Editar curso'

        expect(page).to have_content('já está em uso')
    end
end