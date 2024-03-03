# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:address)).to be_valid
  end

  it 'is not valid without a zip code' do
    expect(build(:address, zip_code: nil)).not_to be_valid
  end
end
