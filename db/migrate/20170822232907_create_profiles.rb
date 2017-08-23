class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :summoner_name
      t.string :main_role
      t.string :secondary_role
      t.string :solo_rank
      t.string :flex_rank
      t.string :phone_number
      t.string :email_address
      t.text :description
      t.timestamps
    end
  end
end
