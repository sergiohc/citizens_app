# frozen_string_literal: true

module Operations
  module Twilio
    class Base < ComposableOperations::Operation
      protected

      def twilio_client
        account_sid = ENV['ACCOUNT_SID']
        auth_token = ENV['AUTH_TOKEN']
        @twilio_client ||= ::Twilio::REST::Client.new(account_sid, auth_token)
      rescue Twilio::REST::RestError => e
        halt e.message
      end
    end
  end
end
