class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendees, through: :attendees_events, source: :attendee
  has_many :attendees_events, foreign_key: :event_id

  scope :upcoming_events, -> { where('date > ?', DateTime.now)}
  scope :past_events, ->  {where('date < ?', DateTime.now)}

  # def self.past_events
  #   where('date < ?', DateTime.now)
  # end

  # def self.upcoming_events
  #   where('date > ?', DateTime.now)
  # end

end


