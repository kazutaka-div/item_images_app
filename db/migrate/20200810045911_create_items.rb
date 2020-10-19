class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null:false
      t.integer :prefecture_id, null:false, default: 0 
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
