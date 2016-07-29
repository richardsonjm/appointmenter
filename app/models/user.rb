class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include PersonConcern
  has_many :patients_ailments, foreign_key: :patient_id
  has_many :ailments, through: :patients_ailments
  has_many :appointments, foreign_key: :patient_id, inverse_of: :patient
  has_many :doctors, through: :appointments, foreign_key: :patient_id

  def ailment_specialty_ids
    ailments.map {|ailment| ailment.specialty_id}
  end
end
