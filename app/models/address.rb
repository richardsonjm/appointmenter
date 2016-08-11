class Address < ActiveRecord::Base
  belongs_to :user, inverse_of: :addresses

  US_STATES = {
    'AL' => 'Alabama',
    'AK' => 'Alaska',
    'AZ' => 'Arizona',
    'AR' => 'Arkansas',
    'CA' => 'California',
    'CO' => 'Colorado',
    'CT' => 'Connecticut',
    'DE' => 'Delaware',
    'DC' => 'District of Columbia',
    'FL' => 'Florida',
    'GA' => 'Georgia',
    'HI' => 'Hawaii',
    'ID' => 'Idaho',
    'IL' => 'Illinois',
    'IN' => 'Indiana',
    'IA' => 'Iowa',
    'KS' => 'Kansas',
    'KY' => 'Kentucky',
    'LA' => 'Louisiana',
    'ME' => 'Maine',
    'MD' => 'Maryland',
    'MA' => 'Massachusetts',
    'MI' => 'Michigan',
    'MN' => 'Minnesota',
    'MS' => 'Mississippi',
    'MO' => 'Missouri',
    'MT' => 'Montana',
    'NE' => 'Nebraska',
    'NV' => 'Nevada',
    'NH' => 'New Hampshire',
    'NJ' => 'New Jersey',
    'NM' => 'New Mexico',
    'NY' => 'New York',
    'NC' => 'North Carolina',
    'ND' => 'North Dakota',
    'OH' => 'Ohio',
    'OK' => 'Oklahoma',
    'OR' => 'Oregon',
    'PA' => 'Pennsylvania',
    'PR' => 'Puerto Rico',
    'RI' => 'Rhode Island',
    'SC' => 'South Carolina',
    'SD' => 'South Dakota',
    'TN' => 'Tennessee',
    'TX' => 'Texas',
    'UT' => 'Utah',
    'VT' => 'Vermont',
    'VA' => 'Virginia',
    'WA' => 'Washington',
    'WV' => 'West Virginia',
    'WI' => 'Wisconsin',
    'WY' => 'Wyoming'
  }.freeze

  VALID_STATES = US_STATES.keys.freeze

  VALID_ADDRESS_TYPES = %w(home business)

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true, inclusion: { in: VALID_STATES,
                                                 message: "is not a US State"}
  validates :zip, presence: true, zip_code: true
  validates :address_type, presence: true, numericality: { less_than: VALID_ADDRESS_TYPES.count,
                                                           greater_than_or_equal_to: 0 }

  geocoded_by :full_street_address
  after_validation :geocode, if: :full_street_address_changed?

  def state_name
    US_STATES[state]
  end

  def full_street_address
    "#{street}, #{city}, #{state}"
  end

  def full_street_address_changed?
    street_changed? || city_changed? || state_changed?
  end

  def address_type_name
    VALID_ADDRESS_TYPES[address_type]
  end

  def self.home_for(user)
    where(address_type: 0, user: user).first
  end
end
