class CreateVinyles < ActiveRecord::Migration[7.1]
  def change
    create_table :vinyles do |t|
      t.string :title
      t.string :artist
      t.text :description
      t.boolean :available
      t.string :quality
      t.string :year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
