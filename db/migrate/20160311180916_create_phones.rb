class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :number, limit: 8

      t.timestamps null: false
    end
  end
