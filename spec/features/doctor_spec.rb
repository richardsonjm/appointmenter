require 'rails_helper'

RSpec.feature "Doctor" do
  before do
    @heart = FactoryGirl.create(:specialty, name: "Heart")
    @doctor = FactoryGirl.create(:doctor)
  end

  scenario "Show the doctor's specialties" do
    @doctor.specialties << @heart
    visit doctor_path(@doctor)
    expect(page).to have_content @heart.name
  end

  scenario "Create doctor with specialty" do
    visit new_doctor_path
    doctor_attributes = attributes_for(:doctor)
    doctor_attributes.except(:state).each do |attribute, value|
      fill_in attribute.to_s.humanize, with: value
    end
    select PersonConcern::US_STATES[doctor_attributes[:state]], from: "State"
    select "Heart", from: "doctor_specialty_ids"
    click_button 'Create Doctor'
    expect(Doctor.last.specialties).to include @heart
  end

  scenario "Change doctor specialty" do
    spine = FactoryGirl.create(:specialty, name: "Spine")
    visit edit_doctor_path(@doctor)
    select "Spine", from: "doctor_specialty_ids"
    click_button 'Update Doctor'
    expect(Doctor.last.specialties).to include spine
    expect(Doctor.last.specialties).not_to include @heart
  end
end
