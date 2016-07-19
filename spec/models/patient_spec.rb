require 'rails_helper'

describe Patient do
  subject { create :patient }

  it { is_expected.to be_valid }

  it_behaves_like 'a person'

  describe "patients_ailments" do
    it { is_expected.to have_many :patients_ailments }
    it { is_expected.to respond_to :patients_ailments }
    it { is_expected.to respond_to :patients_ailment_ids }
  end

  describe "ailments" do
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
end
