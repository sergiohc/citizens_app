# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Municipe, type: :model do
  subject(:municipe) { build(:municipe) }
  describe 'validations' do
    it 'has a valid factory' do
      expect(municipe).to be_valid
    end

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:national_health_card) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:phone_number) }

    it { should validate_uniqueness_of(:cpf).ignoring_case_sensitivity }
    it { should validate_uniqueness_of(:national_health_card).ignoring_case_sensitivity }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { should validate_length_of(:cpf).is_equal_to(11) }

    describe 'CPF validation' do
      context 'when CPF is invalid' do
        it 'is not valid' do
          municipe.cpf = '12341234512'
          expect(municipe).not_to be_valid
          expect(municipe.errors[:cpf]).to include('is invalid')
        end
      end

      context 'when CPF is valid' do
        it 'is valid' do
          expect(municipe).to be_valid
        end
      end
    end

    describe 'age validation' do
      context 'when age is less than 18' do
        before { municipe.birth_date = 17.years.ago }

        it 'is not valid' do
          expect(municipe).not_to be_valid
          expect(municipe.errors[:birth_date]).to include('You must be at least 18 years old')
        end
      end

      context 'when age is more than 100' do
        before { municipe.birth_date = 101.years.ago }

        it 'is not valid' do
          expect(municipe).not_to be_valid
          expect(municipe.errors[:birth_date]).to include('Age seems to be invalid')
        end
      end

      context 'when age is between 18 and 100' do
        before { municipe.birth_date = 50.years.ago }

        it 'is valid' do
          expect(municipe).to be_valid
        end
      end
    end
  end

  describe 'associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should define_enum_for(:status).with_values(inactive: 0, active: 1) }
  end
end
