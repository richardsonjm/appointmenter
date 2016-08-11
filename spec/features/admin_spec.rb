require 'rails_helper'

RSpec.feature "Admin" do
  before do
    sign_in_as FactoryGirl.create(:admin)
    @patient = FactoryGirl.create(:patient)
    @doctor = FactoryGirl.create(:ny_doctor)
    visit users_path
  end

  scenario "Admin can change patient email" do
    new_email = 'new@example.com'
    find(:xpath, "//a[@href='#{edit_user_path(@patient)}']").click
    expect {
      fill_in 'Email', with: new_email
      click_button 'Update User'
      @patient.reload
    }.to change(@patient, :email)
    expect(@patient.email).to eq new_email
  end

  scenario "Admin can change patient address attribute" do
    new_city = 'Brooklyn'
    home_address = Address.home_for(@patient)
    find(:xpath, "//a[@href='#{edit_user_path(@patient)}']").click
    expect {
      fill_in 'City', with: new_city
      click_button 'Update User'
      home_address.reload
    }.to change(home_address, :city)
    expect(home_address.city).to eq new_city
  end

  scenario "Admin can change patient ailment" do
    new_ailment = FactoryGirl.create(:ailment)
    find(:xpath, "//a[@href='#{edit_user_path(@patient)}']").click
    expect {
      select Ailment.second.name, from: 'Ailments'
      click_button 'Update User'
      @patient.reload
    }.to change(@patient.ailments, :count).by(1)
    expect(@patient.ailments).to include new_ailment
  end

  scenario "Admin can change doctor specialty" do
    new_specialty = FactoryGirl.create(:specialty)
    find(:xpath, "//a[@href='#{edit_user_path(@doctor)}']").click
    expect {
      select Specialty.last.name, from: 'Specialties'
      click_button 'Update User'
      @doctor.reload
    }.to change(@doctor.specialties, :count).by(1)
    expect(@doctor.specialties).to include new_specialty
  end
end
