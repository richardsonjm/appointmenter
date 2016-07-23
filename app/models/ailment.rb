class Ailment < ActiveRecord::Base
  has_many :patients_ailments
  has_many :patients, through: :patients_ailments
  belongs_to :specialty

  def self.valid_names
    ENV['AILMENTS'].split(':')
  end

  validates :name, presence: true, inclusion: { in: self.valid_names,
    message: "%{value} is not a valid ailment" }

end
