class Course < ApplicationRecord
  has_many :teachers, through: :course_teachers, foreign_key: 'teacher_id'
end
