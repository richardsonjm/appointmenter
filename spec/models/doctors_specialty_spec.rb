require 'rails_helper'

RSpec.describe DoctorsSpecialty, type: :model do
  before { @doctors_specialty = FactoryGirl.build(:doctors_specialty) }

  subject { @doctors_specialty }

  describe "database fields" do
    it { is_expected.to have_db_column(:doctor_id) }
    it { is_expected.to have_db_column(:specialty_id) }
  end

  describe "doctor_id" do
    it { is_expected.to belong_to :doctor }
    it { is_expected.to respond_to :doctor }
    it { is_expected.to respond_to :doctor_id }
  end

  describe "specialty_id" do
    it { is_expected.to belong_to :specialty }
    it { is_expected.to respond_to :specialty }
    it { is_expected.to respond_to :specialty_id }
  end
end
