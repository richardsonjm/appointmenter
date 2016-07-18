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

  describe "#name_and_specialties" do
    before do
      @specialty = FactoryGirl.create(:specialty)
      subject.specialties << @specialty
    end

    it "list speciatly after name" do
      expect(subject.name_and_specialties).to eq "#{subject.name} (#{@specialty.name})"
    end

    it "lists multiple speciatlies after name" do
      specialty2 = FactoryGirl.create(:specialty)
      subject.specialties << specialty2
      expect(subject.name_and_specialties).to eq "#{subject.name} (#{@specialty.name}, #{specialty2.name})"
    end
  end

  describe "#self.patient_doctors" do
    before do
      specialties = FactoryGirl.create_list(:specialty, 3)
      ailments = specialties.map do |specialty|
        FactoryGirl.create(:ailment, specialty: specialty)
      end
      @patient = FactoryGirl.create(:patient, ailments: ailments[0..1])
      @patient_doctors = [0,1].map do |index|
        FactoryGirl.create(:doctor, specialties: [specialties[index]])
      end
      other_doctors = FactoryGirl.create_list(:doctor, 3, specialties: [specialties[2]])
    end

    it "returns doctors with specialties that match patient ailments" do
      expect(Doctor.patient_doctors(@patient)).to eq @patient_doctors
    end
  end
end
