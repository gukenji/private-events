class Invitation < ApplicationRecord
  belongs_to :invited_user, class_name: "User"
  belongs_to :event, class_name: "Event"
  belongs_to :sender, class_name: "User"

  scope :invites_received, -> (user) { where('invited_user_id == ? ', user.id) }
  scope :invites_sended, -> (user) { where('sender_id == ? ', user.id) }
end
