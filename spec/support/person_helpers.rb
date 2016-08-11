module Person
  module TestHelpers
    def fill_person_form(attributes)
      attributes.except(:state, :role, :confirmed_at).each do |attribute, value|
        fill_in attribute.to_s.humanize, with: value
      end
      select Address::US_STATES[attributes[:state]], from: "State"
    end

    def sign_in_as(user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456789'
      click_button 'Log in'
    end
  end
end
