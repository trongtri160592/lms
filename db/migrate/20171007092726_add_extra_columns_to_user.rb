class AddExtraColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :public_info, :boolean
    add_column :users, :biography, :text
  end
end
