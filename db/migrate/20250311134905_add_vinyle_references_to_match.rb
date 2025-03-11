class AddVinyleReferencesToMatch < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :vinyle_a, :integer
    add_column :matches, :vinyle_b, :integer
    add_foreign_key :matches, :vinyles, column: :vinyle_a
    add_foreign_key :matches, :vinyles, column: :vinyle_b
    add_index :matches, [:vinyle_a, :vinyle_b], unique: true, name: 'index_vinyles_matches'
  end
end
