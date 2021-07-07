FactoryBot.define do
  factory :course do
    name { 'Geografia' }
    description { 'Curso de geografia' }
    sequence(:code) { |n| "GEOCURSO#{n}" }
    price { rand(10..100) }
    enrollment_deadline { Time.current }
    teacher
  end

  trait :expired do
    enrollment_deadline { 2.days.ago }
  end
end