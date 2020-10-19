class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :zipcode
      t.text :address
      t.references :user
      t.timestamps
    end
  end
end
