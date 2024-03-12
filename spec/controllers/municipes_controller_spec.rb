# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.describe MunicipesController, type: :controller do
  include TwilioOperationHelpers

  let(:valid_attributes) do
    FactoryBot.attributes_for(:municipe, phone_number: '+5541998254341').merge(
      address_attributes: FactoryBot.attributes_for(:address)
    )
  end

  describe 'POST #create' do
    it 'creates a new Municipe and redirects to the success page with a flash message', :vcr do
      post :create, params: { municipe: valid_attributes }, as: :turbo_stream
      expect(flash[:success]).to eq('Municipe created')
    end
  end

  describe 'PUT #update' do
    let(:municipe) { create(:municipe, phone_number: '+5541998254341', status: 0) }
    let(:valid_attributes) { { first_name: 'Updated Name', status: 0 } }

    context 'with valid params' do
      it 'update to the municipe', :vcr do
        put :update, params: { id: municipe.id, municipe: valid_attributes }, as: :turbo_stream
        expect(flash[:success]).to eq('Municipe updated')
        expect(municipe.reload.first_name).to eq(valid_attributes[:first_name])
      end

      it 'update status and send mailer and sms', :vcr do
        valid_attributes[:status] = 1
        put :update, params: { id: municipe.id, municipe: valid_attributes }, as: :turbo_stream
        expect(Sidekiq::Worker.jobs.size).to eq(2)
      end
    end
  end
end
