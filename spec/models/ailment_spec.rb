require 'rails_helper'

RSpec.describe Ailment, type: :model do
  subject { FactoryGirl.create(:ailment) }

  it { is_expected.to be_valid }

  describe "database fields" do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe '#name' do
    it { is_expected.to respond_to :name }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "patients_ailments" do
    it { is_expected.to have_many :patients_ailments }
    it { is_expected.to respond_to :patients_ailments }
    it { is_expected.to respond_to :patients_ailment_ids }
  end

  describe "patients" do
    it { is_expected.to have_many :patients }
    it { is_expected.to respond_to :patients }
    it { is_expected.to respond_to :patient_ids }
  end
end
