# frozen_string_literal: true

module Operations
  module Twilio
    class Lookup < Base
      processes :phone_number

      def execute
        validate_phone_number
      end

      private

      def validate_phone_number
        twilio_client.lookups.v2.phone_numbers(phone_number).fetch
      rescue ::Twilio::REST::RestError => e
        halt e
      end
    end
  end
end
