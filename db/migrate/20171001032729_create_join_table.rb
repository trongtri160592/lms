class CreateJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :groups, :roles do |t|
      # t.index [:group_id, :role_id]
      # t.index [:role_id, :group_id]
    end
  end
end
