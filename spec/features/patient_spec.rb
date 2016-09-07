require 'rails_helper'

RSpec.feature "Patient" do
  before do
    @rash = FactoryGirl.create(:ailment, name: "Rash")
    @patient = FactoryGirl.create(:patient)
  end

  scenario "Show the patient's ailments" do
    sign_in_as(@patient)
    @patient.ailments << @rash
    visit user_path(@patient)
    expect(page).to have_content @rash.name
  end

  scenario "Create patient with ailment" do
    visit new_user_registration_path
    fill_user_form(attributes_for(:patient))
    select "Rash", from: "user_ailment_ids"
    click_button 'Sign up'
    expect(User.last.ailments).to include @rash
  end

  scenario "Change patient ailment" do
    sign_in_as(@patient)
    fever = FactoryGirl.create(:ailment, name: "Fever")
    visit edit_user_registration_path(@patient)
    select "Fever", from: "user_ailment_ids"
    click_button 'Update'
    expect(User.last.ailments).to include fever
    expect(User.last.ailments).not_to include @rash
  end
end
