require 'rails_helper'

RSpec.feature "Doctor" do
  before do
    @heart = FactoryGirl.create(:specialty, name: "Heart")
    @doctor = FactoryGirl.create(:doctor)
  end

  scenario "Show the doctor's specialties" do
    @doctor.specialties << @heart
    visit user_path(@doctor)
    expect(page).to have_content @heart.name
  end

  scenario "Create doctor with specialty" do
    visit new_user_path
    fill_person_form(attributes_for(:doctor))
    select "Heart", from: "user_specialty_ids"
    click_button 'Create User'
    expect(User.last.specialties).to include @heart
  end

  scenario "Change doctor specialty" do
    spine = FactoryGirl.create(:specialty, name: "Spine")
    visit edit_user_path(@doctor)
    select "Spine", from: "user_specialty_ids"
    click_button 'Update User'
    expect(User.last.specialties).to include spine
    expect(User.last.specialties).not_to include @heart
  end
end
