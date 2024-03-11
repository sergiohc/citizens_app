# frozen_string_literal: true

class CitizensController < ApplicationController
  before_action :citizens, only: %i[index update create]
  before_action :citizen,  only: %i[show edit update]
  before_action :build_citizen, only: %i[new]

  include Pagy::Backend

  def index
    flash.keep if turbo_frame_request?
  end

  def show; end

  def edit; end

  def update
    operation = Operations::Citizens::Update.new(citizen_params)
    operation.object = @citizen
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.turbo_stream { flash.now[:success] = 'Citizen updated' }
      else
        format.turbo_stream { flash.now[:danger] = 'Não foi possivel atualizar' }
      end
    end
  end

  def new; end

  def create
    operation = Operations::Citizens::Create.new(citizen_params)
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.turbo_stream { flash.now[:success] = 'Citizen created' }
      else
        msg = operation.errors.messages
        format.turbo_stream { flash.now[:danger] = msg }
      end
    end
  end

  private

  def citizen
    @citizen = Citizen.find(params[:id])
  end

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
                                    :email, :birth_date, :phone_number, :status, :photo,
                                    address_attributes: %i[street ibge_code neighborhood city state zip_code])
  end
end
