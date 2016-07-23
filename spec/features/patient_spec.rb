require 'rails_helper'

RSpec.feature "Patient" do
  before do
    @ailment = FactoryGirl.create(:ailment, name: Ailment.valid_names.first)
    @patient = FactoryGirl.create(:patient)
  end

  scenario "Show the patient's ailments" do
    @patient.ailments << @ailment
    visit patient_path(@patient)
    expect(page).to have_content @ailment.name
  end

  scenario "Create patient with ailment" do
    visit new_patient_path
    fill_person_form(attributes_for(:patient))
    select @ailment.name, from: "patient_ailment_ids"
    click_button 'Create Patient'
    expect(Patient.last.ailments).to include @ailment
  end

  scenario "Change patient ailment" do
    ailment_two = FactoryGirl.create(:ailment, name: Ailment.valid_names.second)
    visit edit_patient_path(@patient)
    select ailment_two.name, from: "patient_ailment_ids"
    click_button 'Update Patient'
    expect(Patient.last.ailments).to include ailment_two
    expect(Patient.last.ailments).not_to include @ailment
  end
end
