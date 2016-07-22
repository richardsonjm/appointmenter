require 'rails_helper'

RSpec.describe Appointment, type: :model do
  before { @appointment = FactoryGirl.build(:appointment) }

  subject { @appointment }

  it { is_expected.to be_valid }

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
    it { is_expected.to validate_presence_of(:doctor) }
  end

  describe "patient_id" do
    it { is_expected.to belong_to :patient }
    it { is_expected.to respond_to :patient }
    it { is_expected.to respond_to :patient_id }
    it { is_expected.to validate_presence_of(:patient) }
  end

  describe "#date_must_be_at_least_three_days_away" do
    before { @invalid_appointment = FactoryGirl.build(:appointment, date: DateTime.now) }

    it "should require a valid date" do
      expect(@invalid_appointment).not_to be_valid
    end

    it "should add expires_at errors to error messages" do
      @invalid_appointment.valid?
      expect(@invalid_appointment.errors[:date]).to be_present
    end
  end

  describe "#doctor_specialty_matches_patient_ailment" do
    before do
      ailment = FactoryGirl.create(:ailment)
      patient = FactoryGirl.create(:patient, ailments: [ailment])
      doctor = FactoryGirl.create(:doctor, specialties: [FactoryGirl.create(:specialty)])
      @invalid_appointment = FactoryGirl.build(:appointment, doctor: doctor, patient: patient)
  end

    it "should require match between doctor and patient" do
      expect(@invalid_appointment).not_to be_valid
    end

    it "should add expires_at errors to error messages" do
      @invalid_appointment.valid?
      expect(@invalid_appointment.errors[:doctor_id]).to be_present
    end
  end
end
