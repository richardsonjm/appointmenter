require 'rails_helper'

RSpec.feature "Patient" do
  before do
    @rash = FactoryGirl.create(:ailment, name: "Rash")
    @patient = FactoryGirl.create(:patient)
  end

  scenario "Show the patient's ailments" do
    @patient.ailments << @rash
    visit patient_path(@patient)
    expect(page).to have_content @rash.name
  end

  scenario "Create patient with ailment" do
    visit new_patient_path
    fill_person_form(attributes_for(:patient))
    select "Rash", from: "patient_ailment_ids"
    click_button 'Create Patient'
    expect(Patient.last.ailments).to include @rash
  end

  scenario "Change patient ailment" do
    fever = FactoryGirl.create(:ailment, name: "Fever")
    visit edit_patient_path(@patient)
    select "Fever", from: "patient_ailment_ids"
    click_button 'Update Patient'
    expect(Patient.last.ailments).to include fever
    expect(Patient.last.ailments).not_to include @rash
  end
end
