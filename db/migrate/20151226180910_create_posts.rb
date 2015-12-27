class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.string :category
      t.string :photo
      t.string :description
      t.timestamps null: false
    end
  end
end
