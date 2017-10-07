class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :sex, :tinyint
    add_column :users, :active, :boolean
    add_column :users, :date_of_birth, :datetime
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :workplace, :string
    add_column :users, :academic_degree, :string
  end
end
