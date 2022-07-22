class AddReferenceToPostEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendees_events, :event
    add_reference :attendees_events, :attendee
  end
end
