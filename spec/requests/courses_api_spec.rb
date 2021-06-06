require 'rails_helper'

describe 'Courses API' do
    context 'GET /api/v1/courses' do
        it 'should get courses' do
            teacher = Teacher.create!(name: 'Gonzaga',
                                      email: 'gonzaga.prof@code.com')
            Course.create!(name: 'Geografia', description: 'Curso de geografia',
                           code: 'GEOCURSO', price: 30,
                           enrollment_deadline: 1.month.from_now, teacher: teacher)
            Course.create!(name: 'História', description: 'Curso de história',
                           code: 'HISCURSO', price: 25,
                           enrollment_deadline: 1.day.ago, teacher: teacher)

            get '/api/v1/courses'

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body.count).to eq(Course.count)
            expect(parsed_body[0]['name']).to include('Geografia')
            expect(parsed_body[1]['name']).to include('História')
        end

        it 'returns no course' do
            get '/api/v1/courses'

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            parsed_body = JSON.parse(response.body)
            expect(parsed_body).to be_empty
        end
    end

    context 'GET /api/v1/courses/:code' do
        it 'should return a course' do
            teacher = Teacher.create!(name: 'Gonzaga',
                                      email: 'gonzaga.prof@code.com')
            course = Course.create!(name: 'Geografia', description: 'Curso de geografia',
                                    code: 'GEOCURSO', price: 30,
                                    enrollment_deadline: 1.month.from_now, teacher: teacher)
            Course.create!(name: 'História', description: 'Curso de história',
                           code: 'HISCURSO', price: 25,
                           enrollment_deadline: 1.day.ago, teacher: teacher)

            get "/api/v1/courses/#{course.code}"

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            expect(parsed_body['code']).to eq('GEOCURSO')
            expect(response.body).to_not include('HISCURSO')
        end

        it 'should not find course by code' do
            get '/api/v1/courses/ABC0123'

            expect(response).to have_http_status(404)
        end

        private

        def parsed_body
            JSON.parse(response.body)
        end
    end
end