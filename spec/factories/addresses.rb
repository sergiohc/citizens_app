# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    municipe
    zip_code { FFaker::AddressBR.zip_code }
    street { FFaker::AddressBR.street_name }
    neighborhood { FFaker::AddressBR.neighborhood }
    city { FFaker::AddressBR.city }
    state { FFaker::AddressBR.state_abbr }
    ibge_code { nil }
  end
end
