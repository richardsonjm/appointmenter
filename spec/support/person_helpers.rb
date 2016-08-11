module Person
  module TestHelpers
    def fill_person_form(attributes)
      attributes.except(:role, :confirmed_at).each do |attribute, value|
        fill_in attribute.to_s.humanize, with: value
      end
      address_attributes = attributes_for(:address)
      address_attributes.except(:state, :address_type).each do |attribute, value|
        fill_in attribute.to_s.humanize, with: value
      end
      select Address::US_STATES[address_attributes[:state]], from: "State"
    end

    def sign_in_as(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456789'
      click_button 'Log in'
    end
  end
end
