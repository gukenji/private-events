class AddSenderToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_reference :invitations, :sender
  end
end
