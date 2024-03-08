# frozen_string_literal: true

module Operations
  module Twilio
    class Lookup < Base
      processes :params

      attr_reader :client, :validator

      delegate :errors, to: :validator

      def execute
        build
        validate
        persist
        @object
      end

      private

      def build
        @object = twilio_client
      end

      def persist
        @object.lookups.v2.phone_numbers(params).fetch
      end
    end
  end
end
