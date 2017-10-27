class CourseTeacher < ApplicationRecord
  self.table_name = "courses_teachers"
  belongs_to :teacher, foreign_key: 'teacher_id', class_name: 'User'
  belongs_to :course
end
