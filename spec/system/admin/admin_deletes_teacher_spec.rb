require 'rails_helper'

describe 'admin deletes teacher' do
    it 'successfully' do
        teacher1 = Teacher.create!(name: 'Gonzaga',
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia',)

        teacher1.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')

        visit teacher_path(teacher1)
        expect { click_on 'Apagar' }.to change { Teacher.count }.by(-1)

        expect(current_path).to eq(teachers_path)
    end

end