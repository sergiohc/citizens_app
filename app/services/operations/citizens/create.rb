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
          NotifyMunicipeCanBeCreatedJob.perform_later(@object)
        else
          halt @object.errors
        end
      end
    end
  end
end
