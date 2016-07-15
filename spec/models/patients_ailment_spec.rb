require 'rails_helper'

RSpec.describe PatientsAilment, type: :model do
  before { @patients_ailment = FactoryGirl.build(:patients_ailment) }

  subject { @patients_ailment }

  describe "database fields" do
    it { is_expected.to have_db_column(:patient_id) }
    it { is_expected.to have_db_column(:ailment_id) }
  end

  describe "patient_id" do
    it { is_expected.to belong_to :patient }
    it { is_expected.to respond_to :patient }
    it { is_expected.to respond_to :patient_id }
  end

  describe "ailment_id" do
    it { is_expected.to belong_to :ailment }
    it { is_expected.to respond_to :ailment }
    it { is_expected.to respond_to :ailment_id }
  end
end
