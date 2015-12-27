class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :user
      t.integer :friend_id
      t.string :status, :limit => 15
      t.timestamps null: false
    end
  end
end
