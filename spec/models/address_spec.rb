# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'has a valid factory' do
    expect(build(:address)).to be_valid
  end

  # Presence validations
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:neighborhood) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }

  # Association test
  it { should belong_to(:citizen) }
end
