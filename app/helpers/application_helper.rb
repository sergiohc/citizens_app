# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def render_flash_messages
    flash.map do |type, message|
      render(FlashComponent.new(id: "toast-#{type}", message: message, type: type))
    end.join.html_safe # rubocop:disable Rails/OutputSafety
  end
end
