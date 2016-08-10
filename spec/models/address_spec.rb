require 'rails_helper'

RSpec.describe Address, type: :model do
  subject { FactoryGirl.create(:address) }

  it { is_expected.to be_valid }

  describe "database fields" do
    it { is_expected.to have_db_column(:street) }
    it { is_expected.to have_db_column(:city) }
    it { is_expected.to have_db_column(:state) }
    it { is_expected.to have_db_column(:zip) }
    it { is_expected.to have_db_column(:address_type) }
    it { is_expected.to have_db_column(:user_id) }
  end

  describe '#street' do
    it { is_expected.to respond_to :street }
    it { is_expected.to validate_presence_of(:street) }
  end

  describe '#city' do
    it { is_expected.to respond_to :city }
    it { is_expected.to validate_presence_of(:city) }
  end

  describe '#state' do
    it { is_expected.to respond_to :state }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_inclusion_of(:state).in_array(Address::VALID_STATES) }
  end

  describe '#zip' do
    it { is_expected.to respond_to :zip }
    it { is_expected.to validate_presence_of(:zip) }
    context 'when valid' do
      before { subject.zip = '90210' }

      it { is_expected.to be_valid }
    end

    context 'when not valid' do
      before { subject.zip = 'invalid zip' }

      it { is_expected.to_not be_valid }
    end
  end

  describe '#address_type' do
    it { is_expected.to respond_to :address_type }
    it { is_expected.to validate_presence_of(:address_type) }
    it { is_expected.to validate_numericality_of(:address_type).
      is_less_than(Address::VALID_ADDRESS_TYPES.count).
      is_greater_than_or_equal_to(0) }

    context 'when valid' do
      before { subject.address_type = 1 }

      it { is_expected.to be_valid }
    end

    context 'when not valid' do
      before { subject.address_type = Address::VALID_ADDRESS_TYPES.count }

      it { is_expected.to_not be_valid }
    end
  end

  describe "#user" do
    it { is_expected.to belong_to :user }
    it { is_expected.to respond_to :user }
    it { is_expected.to respond_to :user_id }
  end

  describe '#full_street_address' do
    it "combines street, city and state into single string" do
      expect(subject.full_street_address).to eq "#{subject.street}, #{subject.city}, #{subject.state}"
    end
  end
end
