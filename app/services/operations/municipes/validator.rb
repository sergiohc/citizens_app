# frozen_string_literal: true

module Operations
  module Municipes
    class Validator
      include ActiveModel::Model

      attr_reader :municipe

      def initialize(municipe)
        @municipe = municipe
      end

      private

      def validate_municipe
        return if municipe.valid?

        municipe.errors.messages.each do |attribute, message|
          errors.add(attribute, message)
        end
      end

      def validate_address
        return if municipe.address.valid?

        municipe.address.errors.messages.each do |attribute, message|
          errors.add(attribute, message)
        end
      end
    end
  end
end
