class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mobile_no, :limit => 15
      t.datetime :date_of_birth
      t.string :gender, :limit => 15
      t.string :address
      t.string :password
      t.string :photo
      t.timestamps null: false
    end
  end
end
