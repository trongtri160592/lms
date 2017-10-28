class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.references :course, foreign_key: true

      t.timestamps

    end
    add_column :lessons, :name, :string
    add_reference :lessons, :lesson_type, foreign_key: true
    add_reference :lessons, :user, foreign_key: true
    add_column :lessons, :avatar, :string
    add_column :lessons, :url, :string
    add_column :lessons, :approved, :tinyint
  end
end
