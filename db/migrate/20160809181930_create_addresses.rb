class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.integer :address_type, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
