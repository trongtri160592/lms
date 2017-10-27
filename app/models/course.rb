class Course < ApplicationRecord
  has_many :course_teachers, class_name: 'CourseTeacher'
  has_many :teachers, through: :course_teachers, source: :teacher
  belongs_to :head_teacher, class_name: 'Teacher'
end
