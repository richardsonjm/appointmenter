module Person
  module TestHelpers
    def fill_person_form(attributes)
      attributes.except(:state).each do |attribute, value|
        fill_in attribute.to_s.humanize, with: value
      end
      select PersonConcern::US_STATES[attributes[:state]], from: "State"
    end
  end
end
