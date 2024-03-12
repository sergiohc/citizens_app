# frozen_string_literal: true

class NotifyMunicipeCanBeCreatedJob < ApplicationJob
  queue_as :default

  def perform(municipe)
    MunicipeMailer.notify_municipe_created(municipe).deliver_later
  end
end
