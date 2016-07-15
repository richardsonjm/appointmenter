require 'rails_helper'
require 'support/person_examples'

describe Doctor do
  subject { create :doctor }

  it { is_expected.to be_valid }

  it_behaves_like 'a person'

  describe '#name' do
    let(:name) { subject.name }

    it 'starts with "Dr. "' do
      expect(name.starts_with?('Dr. ')).to be_truthy
    end
  end

  describe "doctors_specialties" do
    it { is_expected.to have_many :doctors_specialties }
    it { is_expected.to respond_to :doctors_specialties }
    it { is_expected.to respond_to :doctors_specialty_ids }
  end

  describe "specialties" do
    it { is_expected.to have_many :specialties }
    it { is_expected.to respond_to :specialties }
    it { is_expected.to respond_to :specialty_ids }
  end

  describe "appointments" do
    it { is_expected.to have_many :appointments }
    it { is_expected.to respond_to :appointments }
    it { is_expected.to respond_to :appointment_ids }
  end

  describe "patients" do
    it { is_expected.to have_many :patients }
    it { is_expected.to respond_to :patients }
    it { is_expected.to respond_to :patient_ids }
  end
end
