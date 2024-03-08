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
            NotifyMunicipeCanBeStatusUpdatedJob
              .perform_later(@object)
          end
        else
          halt @object.errors
        end
      end
    end
  end
end
