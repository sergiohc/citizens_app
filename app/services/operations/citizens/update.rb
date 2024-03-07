# frozen_string_literal: true

module Operations
  module Citizens
    class Update < ComposableOperations::Operation
      processes :params

      attr_accessor :object
      attr_reader :validator

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
        return @object if @object.update(params)

        halt @object.errors
      end
    end
  end
end
