require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  subject { @ability }

  describe "as admin" do
    before do
      @admin = FactoryGirl.create(:admin)
      @ability = Ability.new(@admin)
    end

    context "ailments" do
      it {should be_able_to(:manage, Ailment)}
    end

    context "appointments" do
      it {should be_able_to(:manage, Appointment)}
    end

    context "doctors specialties" do
      it {should be_able_to(:manage, DoctorsSpecialty)}
    end

    context "patients ailments" do
      it {should be_able_to(:manage, PatientsAilment)}
    end

    context "specialties" do
      it {should be_able_to(:manage, Specialty)}
    end

    context "users" do
      it {should be_able_to(:manage, User)}
    end
  end

  describe "as patient" do
    before do
      @patient = FactoryGirl.create(:patient)
      @ability = Ability.new(@patient)
    end

    context "users" do
      it {should     be_able_to(:index, FactoryGirl.create(:doctor))}
      it {should_not be_able_to(:index, FactoryGirl.create(:patient))}
      it {should     be_able_to(:show, @patient)}
      it {should_not be_able_to(:show, FactoryGirl.create(:patient))}
      it {should_not be_able_to(:manage, User)}
    end

    context "appointments" do
      it {should      be_able_to(:create, Appointment)}
      it {should      be_able_to(:show, FactoryGirl.create(:appointment, patient: @patient))}
      it {should      be_able_to(:update, FactoryGirl.create(:appointment, patient: @patient))}
      it {should      be_able_to(:destroy, FactoryGirl.create(:appointment, patient: @patient))}
      it {should_not  be_able_to(:show, FactoryGirl.create(:appointment))}
      it {should_not  be_able_to(:update, FactoryGirl.create(:appointment))}
      it {should_not  be_able_to(:destroy, FactoryGirl.create(:appointment))}
    end

    context "patients ailments" do
      it {should      be_able_to(:create, PatientsAilment)}
      it {should      be_able_to(:destroy, @patient.patients_ailments.first)}
      it {should_not  be_able_to(:destroy, FactoryGirl.create(:patients_ailment))}
    end

    context "ailments" do
      it {should be_able_to(:read, Ailment)}
    end

    context "specialties" do
      it {should be_able_to(:read, Specialty)}
    end
  end

  describe "as doctor" do
    before do
      @doctor = FactoryGirl.create(:doctor)
      @ability = Ability.new(@doctor)
    end

    context "users" do
      it {should     be_able_to(:index, FactoryGirl.create(:doctor))}
      it {should_not be_able_to(:index, FactoryGirl.create(:patient))}
      it {should     be_able_to(:show, @doctor)}
      it {should_not be_able_to(:show, FactoryGirl.create(:patient))}
      it {should_not be_able_to(:manage, User)}
    end

    context "appointments" do
      it {should      be_able_to(:create, Appointment)}
      it {should      be_able_to(:show, FactoryGirl.create(:appointment, doctor: @doctor))}
      it {should      be_able_to(:update, FactoryGirl.create(:appointment, doctor: @doctor))}
      it {should_not  be_able_to(:show, FactoryGirl.create(:appointment))}
      it {should_not  be_able_to(:update, FactoryGirl.create(:appointment))}
    end

    context "doctors specialites" do
      it {should      be_able_to(:create, DoctorsSpecialty)}
      it {should      be_able_to(:destroy, @doctor.doctors_specialties.first)}
      it {should_not  be_able_to(:destroy, FactoryGirl.create(:doctors_specialty))}
    end
  end
end
