# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(id:, type:, message:)
    @id = id
    @type = type
    @message = message
  end
end
