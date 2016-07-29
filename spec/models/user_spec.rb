require 'rails_helper'
require 'support/person_examples'

describe User do
  subject { create :user }

  it { is_expected.to be_valid }

  it_behaves_like 'a person'

  describe 'patient' do
    context 'role' do
      subject { create :patient}
      it 'has patient role' do
        expect(subject.has_role? :patient).to be true
      end
    end

    context "patients_ailments" do
      it { is_expected.to have_many :patients_ailments }
      it { is_expected.to respond_to :patients_ailments }
      it { is_expected.to respond_to :patients_ailment_ids }
    end

    context "ailments" do
      it { is_expected.to have_many :ailments }
      it { is_expected.to respond_to :ailments }
      it { is_expected.to respond_to :ailment_ids }
    end

    describe "appointments" do
      it { is_expected.to have_many :appointments }
      it { is_expected.to respond_to :appointments }
      it { is_expected.to respond_to :appointment_ids }
    end

    describe "doctors" do
      it { is_expected.to have_many :doctors }
      it { is_expected.to respond_to :doctors }
      it { is_expected.to respond_to :doctor_ids }
    end

    describe "#specialty_ids" do
      it "returns arary of specialty_ids associated with ailments" do
        expect(subject.specialty_ids).to eq subject.ailments.map {|a| a.specialty_id}
      end
    end
  end
end
