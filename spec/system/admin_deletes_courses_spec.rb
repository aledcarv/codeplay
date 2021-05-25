require 'rails_helper'

describe 'admin deletes courses' do
    it 'successfully' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                  email: 'gonzaga.profteste@code.com')

        course = Course.create!(name: 'Ruby',
                                description: 'Um curso de ruby',
                                code: 'RUBYBASIC',
                                price: '10',
                                enrollment_deadline: '22/12/2033',
                                teacher: teacher)

        visit root_path
        click_on 'Cursos'
        click_on course.name

        expect { click_on 'Apagar' }.to change { Course.count }.by(-1)
        expect(current_path).to eq(courses_path)
    end
end