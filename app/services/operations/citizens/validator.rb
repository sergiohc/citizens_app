# frozen_string_literal: true

module Operations
  module Citizens
    class Validator
      include ActiveModel::Model

      attr_reader :citizen

      def initialize(citizen)
        @citizen = citizen
      end

      private

      def validate_citizen
        return if citizen.valid?

        citizen.errors.messages.each do |attribute, message|
          errors.add(attribute, message)
        end
      end

      def validate_address
        return if citizen.address.valid?

        citizen.address.errors.messages.each do |attribute, message|
          errors.add(attribute, message)
        end
      end
    end
  end
end
