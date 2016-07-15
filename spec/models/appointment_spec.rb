require 'rails_helper'

RSpec.describe Appointment, type: :model do
  before { @appointment = FactoryGirl.build(:appointment) }

  subject { @appointment }

  describe "database fields" do
    it { is_expected.to have_db_column(:doctor_id) }
    it { is_expected.to have_db_column(:patient_id) }
    it { is_expected.to have_db_column(:date).with_options(null: false) }
  end

  describe 'date' do
    it { is_expected.to respond_to :date }
    it { is_expected.to validate_presence_of(:date) }
  end

  describe "doctor_id" do
    it { is_expected.to belong_to :doctor }
    it { is_expected.to respond_to :doctor }
    it { is_expected.to respond_to :doctor_id }
  end

  describe "patient_id" do
    it { is_expected.to belong_to :patient }
    it { is_expected.to respond_to :patient }
    it { is_expected.to respond_to :patient_id }
  end
end
