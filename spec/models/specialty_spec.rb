require 'rails_helper'

RSpec.describe Specialty, type: :model do
  subject { FactoryGirl.create(:specialty) }

  it { is_expected.to be_valid }

  describe "database fields" do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe '#name' do
    it { is_expected.to respond_to :name }
    it { is_expected.to validate_presence_of(:name) }
  end
end
