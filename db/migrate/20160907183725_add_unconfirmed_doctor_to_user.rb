class AddUnconfirmedDoctorToUser < ActiveRecord::Migration
  def change
    add_column :users, :unconfirmed_doctor, :boolean, null: false, default: false
  end
end
