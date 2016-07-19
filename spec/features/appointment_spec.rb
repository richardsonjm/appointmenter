require 'rails_helper'

def create_appointment(datetime)
  within('.new_appointment') {
    fill_in 'appointment[date]', with: datetime.strftime("%Y-%m-%d %l:%M %p")
    page.execute_script "$('#appointment_date').datetimepicker('hide')"
    click_button "Create Appointment"
    loop until page.evaluate_script('jQuery.active').zero?
  }
end

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
    expect {
      create_appointment(Time.now + 4.days)
    }.to change(Appointment, :count).by(1)
    within (find('#patient-appointments')) {
      expect(page).to have_content @doctor.name
    }
  end

  scenario "Won't schedule too soon appointment for patient" do
    visit patient_path(@patient)
    select @doctor.name, from: "appointment_doctor_id"
    expect {
      create_appointment(Time.now)
    }.not_to change(Appointment, :count)
    expect(page).to have_content "can't be less than three days away"
  end

  scenario "Only show local, specialty matched doctors" do
    ca_doctor = FactoryGirl.create(:ca_doctor, specialties: [@dermotology])
    visit patient_path(@patient)
    expect(page).not_to have_select('appointment_doctor_id', options: [ca_doctor.name_and_specialties])
  end
end
