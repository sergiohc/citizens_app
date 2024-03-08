# frozen_string_literal: true

class CitizenMailer < ApplicationMailer
  def notify_municipe_created(citizen)
    @full_name = citizen.full_name

    mail(to: citizen.email, subject: 'Register municipe')
  end

  def notify_municipe_status_updated(citizen)
    @full_name = citizen.full_name

    mail(to: citizen.email, subject: 'Estatus alterado')
  end
end
