# frozen_string_literal: true

# spec/factories/citizens.rb
FactoryBot.define do
  factory :citizen do
    first_name { FFaker::NameBR.first_name }
    last_name { FFaker::NameBR.last_name }
    cpf { FFaker::IdentificationBR.cpf }
    national_health_card { FFaker::Identification.ssn }
    email { FFaker::Internet.email }
    birth_date do
      FFaker::Time.between(Date.new(1900, 1, 1), Date.new(2000, 12, 31)).to_date
    end
    phone_number { FFaker::PhoneNumberBR.international_phone_number }
    status { %w[active inactive].sample }
  end
end
