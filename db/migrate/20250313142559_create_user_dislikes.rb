class CreateUserDislikes < ActiveRecord::Migration[7.1]
  def change
    create_table :user_dislikes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vinyle, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
