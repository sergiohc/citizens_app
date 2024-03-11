# frozen_string_literal: true

module TwilioOperationHelpers
  include VCR

  def stub_valid_lookup_operation
    VCR.use_cassette('twilio_lookup_success') do
      stub_operation(Operations::Twilio::Lookup)
    end
  end

  def stub_failed_lookup_operation
    VCR.use_cassette('twilio_lookup_failure') do
      stub_operation(Operations::Twilio::Lookup, succeeded: false)
    end
  end

  def stub_valid_send_sms_operation
    VCR.use_cassette('twilio_send_sms_success') do
      stub_operation(Operations::Twilio::SendSms)
    end
  end

  private

  def stub_operation(operation_class, succeeded: true)
    operation = instance_double(operation_class)
    allow(operation_class).to receive(:new).and_return(operation)
    allow(operation).to receive(:perform)
    allow(operation).to receive(:succeeded?).and_return(succeeded)
    operation
  end
end
