module StatesHelper
  def us_state_options
    Address::US_STATES.invert
  end
end
