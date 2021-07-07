FactoryBot.define do
  factory :lesson do
    name { 'Efeito estufa' }
    content { 'Aula sobre efeito estufa' }
    course
  end
end
