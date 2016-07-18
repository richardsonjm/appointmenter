require 'rails_helper'

RSpec.feature "Appointment", js: true do
  before do
    @dermotology = FactoryGirl.create(:specialty, name: "Dermotologist")
    rash = FactoryGirl.create(:ailment, name: "Rash", specialty: @dermotology)
    @patient = FactoryGirl.create(:patient, ailments: [rash])
    @doctor = FactoryGirl.create(:doctor, specialties: [@dermotology])
  end

  scenario "Schedule appointment for patient" do
    visit patient_path(@patient)
    select @doctor.name, from: "appointment_doctor_id"
    appointment_date = Time.now + 4.days
    expect {
      select appointment_date.strftime("%Y"), from: "appointment_date_1i"
      select appointment_date.strftime("%B"), from: "appointment_date_2i"
      select appointment_date.strftime("%d"), from: "appointment_date_3i"
      select appointment_date.strftime("%H"), from: "appointment_date_4i"
      select appointment_date.strftime("%M"), from: "appointment_date_5i"
      click_button "Create Appointment"
      loop until page.evaluate_script('jQuery.active').zero?
    }.to change(Appointment, :count).by(1)
    within (find('#patient-appointments')) {
      expect(page).to have_content @doctor.name
    }
  end

  scenario "Won't schedule too soon appointment for patient" do
    visit patient_path(@patient)
    select @doctor.name, from: "appointment_doctor_id"
    appointment_date = Time.now
    expect {
      select appointment_date.strftime("%Y"), from: "appointment_date_1i"
      select appointment_date.strftime("%B"), from: "appointment_date_2i"
      select appointment_date.strftime("%d"), from: "appointment_date_3i"
      select appointment_date.strftime("%H"), from: "appointment_date_4i"
      select appointment_date.strftime("%M"), from: "appointment_date_5i"
      click_button "Create Appointment"
      loop until page.evaluate_script('jQuery.active').zero?
    }.not_to change(Appointment, :count)
    expect(page).to have_content "can't be less than three days away"
  end

  scenario "Only show local, specialty matched doctors" do
    ca_doctor = FactoryGirl.create(:ca_doctor, specialties: [@dermotology])
    visit patient_path(@patient)
    expect(page).not_to have_select('appointment_doctor_id', options: [ca_doctor.name_and_specialties])
  end
end
