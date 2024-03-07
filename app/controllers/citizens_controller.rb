# frozen_string_literal: true

class CitizensController < ApplicationController
  before_action :citizens, only: %i[index update create]
  before_action :build_citizen, only: %i[new]

  include Pagy::Backend

  def index
    flash.keep if turbo_frame_request?
  end

  def show; end

  def edit
    @citizen = Citizen.find(params[:id])
  end

  def update
    @citizen = Citizen.find(params[:id])

    if @citizen.update(citizen_params)
      flash[:success] = 'Citizen updated'
    else
      flash[:danger] = @citizen.errors.full_messages.to_sentence
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  def new; end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      flash[:success] = 'Citizen created'
    else
      flash[:danger] = @citizen.errors.full_messages.to_sentence
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to citizen_path }
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
                                    :email, :birth_date, :phone_number, :status,
                                    address_attributes: %i[street ibge_code neighborhood city state zip_code])
  end
end
