# frozen_string_literal: true

module Operations
  module Citizens
    class Create < ComposableOperations::Operation
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

      def validate
        @validator = ::Operations::Citizens::Validator.new @object

        return if @validator.valid?

        halt @validator.errors
      end

      def build
        @object = Citizen.new(params)
      end

      def persist
        if @object.update(params)
          send_email_notification
          send_sms_message
        else
          halt @object.errors
        end
      end

      def send_email_notification
        NotifyMunicipeCanBeCreatedJob.perform_later(@object)
      end

      def send_sms_message
        sms_params = {
          phone_number: @object.phone_number,
          body: 'Sua solicitação foi atualizada com sucesso.'
        }

        operation = Operations::Twilio::SendSms.new(sms_params)
        operation.perform

        return if operation.succeeded?

        Rails.logger.error("Falha ao enviar SMS: #{operation.errors.join(', ')}")
      end
    end
  end
end
