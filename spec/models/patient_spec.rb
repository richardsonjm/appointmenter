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
end
