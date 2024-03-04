# frozen_string_literal: true

class CitizensController < ApplicationController
  before_action :citizens, only: %i[index]
  include Pagy::Backend

  def index; end

  def show; end

  def edit; end

  def update; end

  def new; end

  def create; end

  private

  def citizens
    @pagy, @citizens = pagy(Citizen.includes(:address).all, items: 5, link_extra: 'data-turbo-frame="search"')
  end

  def citizen_params
    params.require(:citizen).permit(:first_name, :last_name, :cpf, :cns,
                                    :email, :birth_date, :phone, :status)
  end
end
