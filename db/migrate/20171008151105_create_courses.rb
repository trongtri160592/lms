class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :topic
      t.string :avatar
      t.text :introduction
      t.references :author, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
