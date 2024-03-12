# frozen_string_literal: true

class MunicipeMailer < ApplicationMailer
  def notify_municipe_created(municipe)
    @full_name = municipe.full_name

    mail(to: municipe.email, subject: 'Register municipe')
  end

  def notify_municipe_status_updated(municipe)
    @full_name = municipe.full_name

    mail(to: municipe.email, subject: 'Estatus alterado')
  end
end
