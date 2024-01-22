# frozen_string_literal: true

class Event < ApplicationRecord
  include UniqUserCountByTextVariation

  scope :in_period, proc { |start_date, end_date|
    where(created_at: start_date..end_date)
  }
  scope :by_event_name, ->(event_name) { where(event_name:) }

  def self.total_uniq_events_in_period_by_displayed_text_variation_and_action(event_name:, start_date:, end_date:)
    events_in_period_by_event_name = in_period(start_date, end_date).by_event_name(event_name)
    displayed_text_variations = events_in_period_by_event_name.pluck(:displayed_text_variation).uniq
    uniq_user_count_by_text_variation(displayed_text_variations, events_in_period_by_event_name)
  end
end
