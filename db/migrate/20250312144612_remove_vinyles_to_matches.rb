class RemoveVinylesToMatches < ActiveRecord::Migration[7.1]
  def change
    remove_column :matches, :vinyle_a
    remove_column :matches, :vinyle_b
  end
end
