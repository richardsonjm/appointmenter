require "rails_helper"

include AppointmentsHelper

RSpec.describe AppointmentMailer, type: :mailer do
  before do
    @appointment = FactoryGirl.create(:appointment)
  end

  describe "patient_new_appointment" do
    before do
      @patient = @appointment.patient
      @mail = AppointmentMailer.patient_new_appointment(@appointment)
    end

    it "send patient appointment date and location" do
      expect(@mail.subject).to eq("Your upcoming appointment with #{@appointment.doctor.name}")
      expect(@mail.to).to eq([@patient.email])
      expect(@mail.body.encoded).to include human_readable_date(@appointment.date)
      expect(@mail.body.encoded).to include (@appointment.doctor.full_street_address)
    end
  end

  describe "doctor_new_appointment" do
    before do
      @doctor = @appointment.doctor
      @mail = AppointmentMailer.doctor_new_appointment(@appointment)
    end

    it "send doctor appointment date and location" do
      expect(@mail.subject).to eq("New patient appointment")
      expect(@mail.to).to eq([@doctor.email])
      expect(@mail.body.encoded).to include human_readable_date(@appointment.date)
      expect(@mail.body.encoded).to include (@doctor.full_street_address)
    end
  end
end
