class InProgressShift < ApplicationRecord
  belongs_to :company
  belongs_to :scheduling_period
  belongs_to :location
  belongs_to :position
  belongs_to :repeating_shift
  belongs_to :user

  has_many :shifts

  attr_accessor :repeat_frequency, :update_repeating_rule

  validates :minute_start, presence: true
  validates :minute_end, presence: true
  validates :date, presence: true

  after_create :add_repeating_shift

  def self.default_scope
    where(deleted_at: nil)
  end

  def deleted?
    deleted_at.present?
  end

  def repeating?
    repeating_shift_id.present?
  end

  def time_range
    "#{MinutesToTime.for(minute_start)}-#{MinutesToTime.for(minute_end)}"
  end

  private

  def add_repeating_shift
    if repeat_frequency.to_i > 0
      self.create_repeating_shift(minute_end: self.minute_end,
                                  minute_start: self.minute_start,
                                  location_id: self.location_id,
                                  position_id: self.position_id,
                                  repeat_frequency: self.repeat_frequency,
                                  start_date: self.date,
                                  user_id: self.user_id)

      # resave to ensure repeating shift id is also persisted
      self.save
    end
  end
end
