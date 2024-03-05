# frozen_string_literal: true

class CitizensController < ApplicationController
  before_action :citizens, only: %i[index]
  before_action :build_citizen, only: %i[new]

  include Pagy::Backend

  def index; end

  def show; end

  def edit; end

  def update; end

  def new; end

  def create
    respond_to do |format|
      if Citizen.create!(citizen_params)
        format.turbo_stream
      else
        msg = operation.errors.messages
        format.turbo_stream { flash.now[:error] = msg }
      end
    end
  end

  private

  def citizens
    @pagy, @citizens = pagy(Citizen.includes(:address).all, items: 5,
                                                            link_extra: 'data-turbo-frame="search"')
  end

  def build_citizen
    @citizen = Citizen.new
    @citizen.build_address
  end

  def citizen_params
    params.require(:citizen).permit(:first_name, :last_name, :cpf, :national_health_card,
                                    :email, :birth_date, :phone, :status,
                                    address_attributes: %i[street ibge_code neighborhood city state zip_code])
  end
end
