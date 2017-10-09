class CourseTeacher < ApplicationRecord
  self.table_name = "courses_teachers"
  belongs_to :user, foreign_key: "teacher_id"
  belongs_to :course
end
