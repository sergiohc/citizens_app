# frozen_string_literal: true

class NotifyMunicipeCanBeStatusUpdatedJob < ApplicationJob
  queue_as :default

  def perform(municipe)
    MunicipeMailer.notify_municipe_status_updated(municipe).deliver_later
  end
end
