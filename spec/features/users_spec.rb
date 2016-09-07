require 'rails_helper'

RSpec.feature "Users index" do
  before do
    @patients = FactoryGirl.create_list(:patient, 3)
    @doctors = FactoryGirl.create_list(:ny_doctor, 3)
  end

  scenario 'as a patient or doctor' do
    [@patients.first, @doctors.first].each do |user|
      sign_in_as user
      visit users_path
      table = find('table')
      @doctors.each do |doctor|
        within(table) {
          expect(page).to have_content(doctor.name)
          expect(page).to have_content(Address.business_for(doctor).full_street_address)
        }
      end
      @patients.each do |patient|
        within(table) {
          expect(page).not_to have_content(patient.name)
        }
      end
      sign_out
    end
  end

  scenario 'as a admin' do
    sign_in_as FactoryGirl.create(:admin)
    visit users_path
    table = find('table')
    @doctors.each do |doctor|
      within(table) {
        expect(page).to have_content(doctor.name)
        expect(page).to have_content(Address.business_for(doctor).full_street_address)
      }
    end
    @patients.each do |patient|
      within(table) {
        expect(page).to have_content(patient.name)
        expect(page).to have_content(Address.home_for(patient).full_street_address)
      }
    end
  end
end
