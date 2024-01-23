# frozen_string_literal: true

class PageView < ApplicationRecord
  include UniqueUserCountByTextVariation

  scope :in_period, proc { |start_date, end_date|
    where(created_at: Time.zone.parse(start_date).beginning_of_day..Time.zone.parse(end_date).end_of_day)
  }
  scope :by_url, ->(url) { where(url:) }

  def self.in_period_by_displayed_text_variation_and_url(start_date:, end_date:, url:)
    page_views_in_period = in_period(start_date, end_date).by_url(url)
    displayed_text_variations = page_views_in_period.pluck(:displayed_text_variation).uniq

    {
      unique: unique_user_count_by_text_variation(displayed_text_variations, page_views_in_period),
      total: page_views_in_period.group(:displayed_text_variation).count,
      url: page_views_in_period.last&.url
    }
  end
end
