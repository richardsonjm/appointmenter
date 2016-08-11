require 'rails_helper'

RSpec.feature "Doctor" do
  before do
    @heart = FactoryGirl.create(:specialty, name: "Heart")
    @doctor = FactoryGirl.create(:ny_doctor)
  end

  scenario "Show the doctor's specialties" do
    sign_in_as(FactoryGirl.create(:patient))
    @doctor.specialties << @heart
    visit user_path(@doctor)
    expect(page).to have_content @heart.name
  end

  scenario "Create doctor sends verification email" do
    visit new_user_registration_path
    expect {
      fill_person_form(attributes_for(:doctor))
      check 'is_a_doctor'
      click_button 'Sign up'
    }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end

  scenario "Create doctor creates new address" do
    visit new_user_registration_path
    expect {
      fill_person_form(attributes_for(:doctor))
      check 'is_a_doctor'
      click_button 'Sign up'
    }.to change(Address, :count).by(1)
  end

  scenario "Change doctor specialty" do
    sign_in_as(@doctor)
    spine = FactoryGirl.create(:specialty, name: "Spine")
    visit edit_user_registration_path(@doctor)
    select "Spine", from: "user_specialty_ids"
    click_button 'Update'
    expect(User.last.specialties).to include spine
    expect(User.last.specialties).not_to include @heart
  end
end
