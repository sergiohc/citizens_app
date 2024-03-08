# frozen_string_literal: true

module Operations
  module Twilio
    class Base < ComposableOperations::Operation
      protected

      def twilio_client
        account_sid = ENV.fetch('ACCOUNT_SID')
        auth_token = ENV.fetch('AUTH_TOKEN')

        @twilio_client ||= ::Twilio::REST::Client.new(account_sid, auth_token)
      end
    end
  end
end
