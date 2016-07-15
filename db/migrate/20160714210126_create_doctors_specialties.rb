class CreateDoctorsSpecialties < ActiveRecord::Migration
  def change
    create_table :doctors_specialties do |t|
      t.references :doctor, index: true, foreign_key: true
      t.references :specialty, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
