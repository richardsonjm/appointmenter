require 'rails_helper'

RSpec.describe Specialty, type: :model do
  subject { FactoryGirl.create(:specialty) }

  it { is_expected.to be_valid }

  describe "database fields" do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe '#name' do
    it { is_expected.to respond_to :name }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "doctors_specialties" do
    it { is_expected.to have_many :doctors_specialties }
    it { is_expected.to respond_to :doctors_specialties }
    it { is_expected.to respond_to :doctors_specialty_ids }
  end

  describe "specialties" do
    it { is_expected.to have_many :doctors }
    it { is_expected.to respond_to :doctors }
    it { is_expected.to respond_to :doctor_ids }
  end
end
