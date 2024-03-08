# frozen_string_literal: true

class DrawerComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(placement:, title:)
    super
    @placement = placement
    @title = title
  end

  def drawer_id
    "drawer-#{@placement}"
  end

  def drawer_label_id
    "drawer-label-#{@placement}"
  end
end
