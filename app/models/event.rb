# frozen_string_literal: true

class Event < ApplicationRecord
  include UniqueUserCountByTextVariation

  scope :in_period, proc { |start_date, end_date|
    where(created_at: Time.zone.parse(start_date).beginning_of_day..Time.zone.parse(end_date).end_of_day)
  }
  scope :by_event_name, ->(event_name) { where(event_name:) }

  def self.in_period_by_displayed_text_variation_and_action(event_name:, start_date:, end_date:)
    events_in_period_by_event_name = in_period(start_date, end_date).by_event_name(event_name)
    displayed_text_variations = events_in_period_by_event_name.pluck(:displayed_text_variation).uniq

    {
      unique: unique_user_count_by_text_variation(displayed_text_variations, events_in_period_by_event_name),
      total: events_in_period_by_event_name.group(:displayed_text_variation).count,
      url: events_in_period_by_event_name.last&.url
    }
  end
end
