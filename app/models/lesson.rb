class Lesson < ApplicationRecord
  acts_as_commontable

  mount_uploader :file, ScormUploader
  belongs_to :course
  belongs_to :user
  belongs_to :lesson_type

  validates :file, presence: true
  validates :name, presence: true
end
