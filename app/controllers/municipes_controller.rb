# frozen_string_literal: true

class MunicipesController < ApplicationController
  before_action :municipes, only: %i[index update create]
  before_action :municipe,  only: %i[show edit update]
  before_action :build_municipe, only: %i[new]

  include Pagy::Backend

  def index
    flash.keep if turbo_frame_request?
  end

  def show; end

  def edit; end

  def update
    operation = Operations::Municipes::Update.new(municipe_params)
    operation.object = @municipe
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.turbo_stream { flash.now[:success] = 'Municipe updated' }
      else
        format.turbo_stream { flash.now[:danger] = 'Não foi possivel atualizar' }
      end
    end
  end

  def new; end

  def create
    operation = Operations::Municipes::Create.new(municipe_params)
    operation.perform

    respond_to do |format|
      if operation.succeeded?
        format.turbo_stream { flash.now[:success] = 'Municipe created' }
      else
        msg = operation.errors.messages
        format.turbo_stream { flash.now[:danger] = msg }
      end
    end
  end

  private

  def municipe
    @municipe = Municipe.find(params[:id])
  end

  def municipes
    @pagy, @municipes = pagy(Municipe.includes(:address).all, items: 5,
                                                            link_extra: 'data-turbo-frame="search"')
  end

  def build_municipe
    @municipe = Municipe.new
    @municipe.build_address
  end

  def municipe_params
    params.require(:municipe).permit(:first_name, :last_name, :cpf, :national_health_card,
                                    :email, :birth_date, :phone_number, :status, :photo,
                                    address_attributes: %i[street ibge_code neighborhood city state zip_code])
  end
end
