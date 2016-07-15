class AddSpecialtyToAilments < ActiveRecord::Migration
  def change
    add_reference :ailments, :specialty, index: true, foreign_key: true
  end
end
