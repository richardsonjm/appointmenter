class IsADoctorMailer < ApplicationMailer
  def new_doctor_request(resource)
    @new_doctor = resource
    mail(to: ENV['SUPPORT_EMAIL'], subject: "New doctor request from #{@new_doctor.name}")
  end
end
