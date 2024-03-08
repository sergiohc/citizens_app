# frozen_string_literal: true

module Operations
  module Citizens
    class Update < ComposableOperations::Operation
      processes :params

      attr_accessor :object
      attr_reader :validator, :status_changed

      delegate :errors, to: :validator

      def execute
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

      def persist
        if @object.update(params)
          if @object.status_previously_changed?
            send_email_notification
            send_sms_notification
          end
        else
          halt @object.errors
        end
      end

      def send_email_notification
        NotifyMunicipeCanBeStatusUpdatedJob.perform_later(@object)
      end

      def send_sms_notification
        sms_params = {
          phone_number: @object.phone_number,
          body: 'Seu municpe status foi atualizado.'
        }

        operation = Operations::Twilio::SendSms.new(sms_params)
        operation.perform

        return if operation.succeeded?

        Rails.logger.error("Falha ao enviar SMS: #{operation.message}")
        halt operation.message
      end
    end
  end
end
