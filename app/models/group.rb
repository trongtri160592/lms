class Group < ApplicationRecord
  has_many :group_roles, dependent: :destroy
  has_many :roles, through: :group_roles
end
