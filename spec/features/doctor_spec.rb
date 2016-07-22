require 'rails_helper'

RSpec.feature "Doctor" do
  before do
    @specialty_one = FactoryGirl.create(:specialty, name: Specialty.valid_names.first)
    @doctor = FactoryGirl.create(:doctor)
  end

  scenario "Show the doctor's specialties" do
    @doctor.specialties << @specialty_one
    visit doctor_path(@doctor)
    expect(page).to have_content @specialty_one.name
  end

  scenario "Create doctor with specialty" do
    visit new_doctor_path
    fill_person_form(attributes_for(:doctor))
    select @specialty_one.name, from: "doctor_specialty_ids"
    click_button 'Create Doctor'
    expect(Doctor.last.specialties).to include @specialty_one
  end

  scenario "Change doctor specialty" do
    specialty_two = FactoryGirl.create(:specialty, name: Specialty.valid_names.second)
    visit edit_doctor_path(@doctor)
    select specialty_two.name, from: "doctor_specialty_ids"
    click_button 'Update Doctor'
    expect(Doctor.last.specialties).to include specialty_two
    expect(Doctor.last.specialties).not_to include @specialty_one
  end
end
