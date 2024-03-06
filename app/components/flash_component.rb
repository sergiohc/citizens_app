# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(id:, type:, message:)
    @id = id
    @type = type
    @message = message
  end

  private

  def color
    case @type
    when 'success' then 'green'
    when 'danger' then 'red'
    when 'warning' then 'yellow'
    else 'gray'
    end
  end
end
