# frozen_string_literal: true

class NotifyMunicipeCanBeCreatedJob < ApplicationJob
  queue_as :default

  def perform(citizen)
    CitizenMailer.notify_municipe_created(citizen).deliver_later
  end
end
