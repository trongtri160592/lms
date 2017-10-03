class GroupRole < ApplicationRecord
  self.table_name = "groups_roles"
  belongs_to :group
  belongs_to :role
end
