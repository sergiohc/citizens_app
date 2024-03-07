# frozen_string_literal: true

class Citizen < ApplicationRecord
  # One-to-one association with Address. The address is automatically destroyed if the citizen is deleted.
  has_one :address, dependent: :destroy

  # Allows creation/update of an associated address directly within a Citizen's form.
  accepts_nested_attributes_for :address

  # Validates the presence of essential attributes to ensure a Citizen record is complete.
  validates :first_name, :last_name, :cpf, :national_health_card, :birth_date,
            :phone_number, presence: true

  # Ensures CPF is unique and exactly 11 digits long, assuming CPF is stored without formatting.
  validates :cpf, uniqueness: true, length: { is: 11 }

  # Custom validation for the CPF to ensure it adheres to Brazil's CPF format and validity rules.
  validate :validate_cpf

  # Ensures the national health card and email are unique across all records.
  validates :national_health_card, uniqueness: true
  validates :email, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validate min and max age
  validate :validate_age

  # Uses an enum for the 'status' field to neatly map the active (1) and inactive (0) states.
  enum status: { inactive: 0, active: 1 }

  # Validates that the associated address is also valid whenever a Citizen is saved.
  validates_associated :address

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [300, 300]
    attachable.variant :large, resize_to_limit: [600, 600]
  end

  private

  # Validates the CPF for correctness beyond just format, utilizing the 'cpf_cnpj' gem for comprehensive checks.
  def validate_cpf
    # Strips non-numeric characters from CPF and checks validity.
    return if CPF.valid?(cpf.gsub(/[^0-9]/, ''), strict: true)

    errors.add(:cpf, 'is invalid')
  end

  def validate_age
    return if birth_date.blank?

    if birth_date > 18.years.ago.to_date
      errors.add(:birth_date, 'You must be at least 18 years old')
    elsif birth_date < 100.years.ago.to_date
      errors.add(:birth_date, 'Age seems to be invalid') # Mensagem de erro genérica; ajuste conforme necessário.
    end
  end
end
