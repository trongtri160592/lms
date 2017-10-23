class AddHeadTeacherToCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :head_teacher, references: :users
  end
end
