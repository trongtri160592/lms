class AddFileToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :file, :text
  end
end
