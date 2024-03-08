# frozen_string_literal: true

module Operations
  module Twilio
    class SendSms < Base
      processes :params

      attr_reader :object, :validator

      delegate :errors, to: :validator

      def execute
        build
        validate
        persist
        @object
      end

      private

      def build
        @citizen_phone_number = params[:citizen_phone_number]
        @body = params[:body]
        @object = twilio_client
      end

      def validate
        @validator = ::Operations::Twilio::Lookup.new params[:phone_number]
        @validator.perform

        return if @validator.valid?

        halt @validator.errors
      end

      def persist
        @object.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: @citizen_phone_number,
          body: @body
        )
      end
    end
  end
end
