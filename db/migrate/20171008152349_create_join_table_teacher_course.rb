class CreateJoinTableTeacherCourse < ActiveRecord::Migration[5.1]
  def change
    create_join_table :teachers, :courses do |t|
      t.references :teacher, foreign_key: { to_table: :users }, index: true
      # t.index [:teacher_id, :course_id]
      # t.index [:course_id, :teacher_id]
    end
  end
end
