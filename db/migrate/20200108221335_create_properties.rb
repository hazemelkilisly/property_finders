class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      # For enums
      t.integer :property_type, default: 0
      t.integer :marketing_type, default: 0
      t.decimal :lng, precision: 32, scale: 16, default: 0, null: false
      t.decimal :lat, precision: 32, scale: 16, default: 0, null: false
      # I didn't want to concentrate on correctly representing the address data itself in different table
      # but there's a wide field for improvements.
      t.string :house_number
      t.string :street
      t.string :city
      t.string :zip_code
      t.string :state
      # Because for properties, I doubt that there will be decimals for prices
      t.integer :price
      t.timestamps
    end
  end
end
