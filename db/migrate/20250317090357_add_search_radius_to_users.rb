class AddSearchRadiusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :search_radius, :integer
  end
end
