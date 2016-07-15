class CreatePatientsAilments < ActiveRecord::Migration
  def change
    create_table :patients_ailments do |t|
      t.references :patient, index: true, foreign_key: true
      t.references :ailment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
