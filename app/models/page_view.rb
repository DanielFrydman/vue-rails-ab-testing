# frozen_string_literal: true

class PageView < ApplicationRecord
  include UniqUserCountByTextVariation

  scope :in_period, proc { |start_date, end_date|
    where(created_at: start_date..end_date)
  }

  def self.total_uniq_page_views_in_period_by_displayed_text_variation(start_date:, end_date:)
    page_views_in_period = in_period(start_date, end_date)
    displayed_text_variations = page_views_in_period.pluck(:displayed_text_variation).uniq
    uniq_user_count_by_text_variation(displayed_text_variations, page_views_in_period)
  end
end
