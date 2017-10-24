class Course < ApplicationRecord
  has_many :course_teachers
  has_many :teachers, through: :course_teachers, source: :user, foreign_key: 'teacher_id'
  belongs_to :head_teacher, class_name: 'users'
end
