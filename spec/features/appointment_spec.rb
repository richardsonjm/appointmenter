require 'rails_helper'

def fill_and_submit_appointment(datetime, create=true)
  within('.appointment-form') {
    yield if block_given?
    fill_in 'appointment[date]', with: datetime.strftime("%Y-%m-%d %l:%M %p")
    page.execute_script "$('#appointment_date').datetimepicker('hide')"
    create ? click_button("Create Appointment") : click_button("Update Appointment")
    loop until page.evaluate_script('jQuery.active').zero?
  }
end

RSpec.feature "Appointment", js: true do
  before do
    @dermotology = FactoryGirl.create(:specialty, name: "Dermotologist")
    rash = FactoryGirl.create(:ailment, name: "Rash", specialty: @dermotology)
    @patient = FactoryGirl.create(:patient, ailments: [rash])
    @doctor = FactoryGirl.create(:doctor, specialties: [@dermotology])
    sign_in_as(@patient)
  end

  scenario "Schedule appointment for patient" do
    visit user_path(@patient)
    expect {
      fill_and_submit_appointment(Time.now + 4.days) do
        select @doctor.name, from: "appointment_doctor_id"
      end
    }.to change(Appointment, :count).by(1)
    within (find('#doctor-appointments')) {
      expect(page).to have_content @doctor.name
    }
  end

  scenario "Schedule two appointments for patient" do
    visit user_path(@patient)
    expect {
      fill_and_submit_appointment(Time.now + 4.days) do
        select @doctor.name, from: "appointment_doctor_id"
      end
      fill_and_submit_appointment(Time.now + 5.days) do
        select @doctor.name, from: "appointment_doctor_id"
      end
    }.to change(Appointment, :count).by(2)
    within (find('#doctor-appointments')) {
      expect(page).to have_content @doctor.name, count: 2
    }
  end

  scenario "Won't schedule too soon appointment for patient" do
    visit user_path(@patient)
    expect {
      fill_and_submit_appointment(Time.now) do
        select @doctor.name, from: "appointment_doctor_id"
      end
    }.not_to change(Appointment, :count)
    expect(page).to have_content "can't be less than three days away"
  end

  scenario "Only show local, specialty matched doctors" do
    ca_doctor = FactoryGirl.create(:ca_doctor, specialties: [@dermotology])
    visit user_path(@patient)
    expect(page).not_to have_select('appointment_doctor_id', options: [ca_doctor.name_and_specialties])
  end

  scenario "Update appointment date" do
    appointment = FactoryGirl.create(:appointment, patient: @patient, doctor: @doctor)
    visit appointment_path(appointment)
    expect {
      fill_and_submit_appointment(Time.now + 8.days, false)
      appointment.reload
    }.to change(appointment, :date)
  end

  scenario "Won't change date that's too soon" do
    appointment = FactoryGirl.create(:appointment, patient: @patient, doctor: @doctor)
    visit appointment_path(appointment)
    expect {
      fill_and_submit_appointment(Time.now, false)
    }.not_to change(appointment, :date)
    expect(page).to have_content "can't be less than three days away"
  end
end
