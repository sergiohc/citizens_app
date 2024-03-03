# frozen_string_literal: true

FactoryBot.define do
  factory :citizen do
    full_name { 'MyString' }
    cpf { 'MyString' }
    national_health_card { 'MyString' }
    email { 'MyString' }
    birth_date { '2024-03-03' }
    phone { 'MyString' }
    active { 1 }
  end
end
