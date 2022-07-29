class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :attendees_events, foreign_key: :event_id, dependent: :destroy
  has_many :attendees, through: :attendees_events, source: :attendee, dependent: :destroy

  has_many :invitations, foreign_key: :event_id, dependent: :destroy
  has_many :invites, through: :invitations, source: :invited_user, dependent: :destroy

  scope :public_events, -> { where('private == ? ', false) }
  scope :private_events, -> { where('private == ? ', true) }
  scope :upcoming_invited_events, -> (user) { Event.joins(:invitations).where('invitations.invited_user_id == ?', user.id).where('date > ?', DateTime.now) }
  scope :past_invited_events, -> (user) { Event.joins(:invitations).where('invitations.invited_user_id == ?', user.id).where('date < ?', DateTime.now) }


  scope :upcoming_events, -> (user) { where('date > ?', DateTime.now).public_events + upcoming_invited_events(user) }
  scope :past_events, -> (user) { where('date < ?', DateTime.now).public_events + past_invited_events(user) }

  # def self.past_events
  #   where('date < ?', DateTime.now)
  # end

  # def self.upcoming_events
  #   where('date > ?', DateTime.now)
  # end

end


