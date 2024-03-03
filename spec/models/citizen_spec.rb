# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Citizen, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:citizen)).to be_valid
  end

  it 'is not valid without a first name' do
    expect(build(:citizen, first_name: nil)).not_to be_valid
  end

  it 'is not valid with a duplicate email' do
    citizen = create(:citizen)
    expect(build(:citizen, email: citizen.email)).not_to be_valid
  end

  it 'is not valid with an invalid CPF' do
    expect(build(:citizen, cpf: '123')).not_to be_valid
  end
end
