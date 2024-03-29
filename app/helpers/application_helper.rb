# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def display_municipe_photo(municipe,
                            css = 'mb-4 rounded-lg w-28 h-28 sm:mb-0 xl:mb-4 2xl:mb-0')
    if municipe.photo.attached?
      image_tag municipe.photo, data: { previews_target: 'preview' }, class: css
    else
      image_tag 'empty_photo.svg', data: { previews_target: 'preview' },
                                   class: css
    end
  end

  def render_flash_messages
    flash.map do |type, message|
      render(FlashComponent.new(id: "toast-#{type}", message:, type:))
    end.join.html_safe # rubocop:disable Rails/OutputSafety
  end

  def show_icon(path)
    File.open("app/assets/images/icons/#{path}", 'rb') do |file|
      raw file.read # rubocop:disable Rails/OutputSafety
    end
  end
end
