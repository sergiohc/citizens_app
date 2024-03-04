# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

10.times do
  citizen = Citizen.create!(
    first_name: FFaker::NameBR.first_name,
    last_name: FFaker::NameBR.last_name,
    cpf: FFaker::IdentificationBR.cpf,
    national_health_card: FFaker::Identification.ssn,
    birth_date: FFaker::Time.between(30.years.ago, 18.years.ago),
    phone_number: FFaker::PhoneNumberBR.international_phone_number,
    status: %w[active inactive].sample,
    email: FFaker::Internet.email
  )

  citizen.create_address!(
    street: FFaker::AddressBR.street_name,
    neighborhood: FFaker::AddressBR.neighborhood,
    city: FFaker::AddressBR.city,
    state: FFaker::AddressBR.state_abbr,
    zip_code: FFaker::AddressBR.zip_code,
    ibge_code: nil
  )
end
