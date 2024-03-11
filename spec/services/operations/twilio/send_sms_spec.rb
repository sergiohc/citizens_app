# frozen_string_literal: true

RSpec.describe Operations::Twilio::SendSms do
  include TwilioOperationHelpers

  describe '#execute' do
    subject(:operation) { described_class.new(params) }
    let(:params) do
      {
        phone_number: '+5541998254341',
        body: 'Sua solicitação foi atualizada com sucesso.'
      }
    end

    context 'when the phone number is valid' do
      before do
        stub_valid_lookup_operation
      end

      it 'sends an SMS message successfully' do
        VCR.use_cassette('twilio_send_sms_success') do
          expect(operation.perform).to be_truthy
        end
      end
    end

    context 'when the phone number is invalid' do
      before do
        stub_failed_lookup_operation
        params[:phone_number] = ''
      end

      it 'sends an SMS message successfully' do
        VCR.use_cassette('twilio_send_sms_failed') do
          expect(operation.perform).to be_falsy
        end
      end
    end
  end
end
