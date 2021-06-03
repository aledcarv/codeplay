require 'rails_helper'

describe 'admin deletes teacher' do
    it 'successfully' do
        teacher = Teacher.create!(name: 'Gonzaga',
                                   email: 'gonzaga.profteste@code.com',
                                   bio: 'Professor de geografia',)

        teacher.profile_picture.attach(io: File.open('spec/fixtures/teacher-two.jpg'),
                                        filename: 'teacher-two.jpg')

        user_login
        visit admin_teacher_path(teacher)
        expect { click_on 'Apagar' }.to change { Teacher.count }.by(-1)

        expect(current_path).to eq(admin_teachers_path)
    end

end