class DropAddressColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :street
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
    remove_column :users, :latitude
    remove_column :users, :longitude
  end
end
