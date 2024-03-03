# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip_code { 'MyString' }
    street { 'MyString' }
    complement { 'MyString' }
    neighborhood { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    ibge_code { 'MyString' }
    citizen { nil }
  end
end
