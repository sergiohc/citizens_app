# frozen_string_literal: true

module Operations
  module Twilio
    class SendSms < Base
      processes :params

      def initialize(*args, validator: Operations::Twilio::Lookup)
        super(*args)
        @validator = validator.new(params[:phone_number])
      end

      def execute
        validate_phone_number
        send_sms_message
      end

      private

      attr_reader :validator

      def validate_phone_number
        @validator.perform
      rescue StandardError => e
        halt "Validation Failed: #{e.message}"
      end

      def send_sms_message
        twilio_client.messages.create(
          from: ENV.fetch('TWILIO_PHONE'),
          to: params[:phone_number],
          body: params[:body]
        )
      rescue Twilio::REST::RestError => e
        halt "SMS Sending Failed: #{e.message}"
      end
    end
  end
end
