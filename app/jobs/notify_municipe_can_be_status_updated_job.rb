# frozen_string_literal: true

class NotifyMunicipeCanBeStatusUpdatedJob < ApplicationJob
  queue_as :default

  def perform(citizen)
    CitizenMailer.notify_municipe_status_updated(citizen).deliver_later
  end
end
