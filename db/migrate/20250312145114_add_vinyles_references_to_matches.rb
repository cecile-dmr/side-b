class AddVinylesReferencesToMatches < ActiveRecord::Migration[7.1]
  def change
    change_table(:matches) do |t|
      t.references :vinyle1, foreign_key: { to_table: 'vinyles' }
      t.references :vinyle2, foreign_key: { to_table: 'vinyles' }
    end
  end
end
