require 'rails_helper'

RSpec.feature "Ailment" do
  before do
    @specialty = FactoryGirl.create(:specialty, name: "Dermotologist")
    @ailment = FactoryGirl.create(:ailment, name: "Rash", specialty: @specialty)
  end

  scenario "Show the ailment's specialty" do
    visit ailment_path(@ailment)
    expect(page).to have_content @specialty.name
  end

  scenario "Create ailment with specialty" do
    visit new_ailment_path
    fill_in "Name", with: "Rash"
    select "Dermotologist", from: "ailment_specialty_id"
    click_button 'Create Ailment'
    expect(Ailment.last.specialty).to eq @specialty
  end

  scenario "Change ailment specialty" do
    new_specialty = FactoryGirl.create(:specialty)
    visit edit_ailment_path(@ailment)
    select new_specialty.name, from: "ailment_specialty_id"
    click_button 'Update Ailment'
    expect(Ailment.last.specialty).to eq new_specialty
  end
end
