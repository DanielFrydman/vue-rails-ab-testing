# frozen_string_literal: true

class ClickthroughRatePieChartPresenter < PieChartPresenter
  include ActionView::Helpers::NumberHelper

  def initialize(total_uniq_page_views:, total_uniq_events:)
    super(calculate_ctrs(total_uniq_page_views, total_uniq_events))
  end

  private

  def calculate_ctrs(page_views, events)
    result = {}

    page_views.each_key do |key|
      return result[key] = nil if events[key].nil? || page_views[key].zero?

      result[key] = number_to_percentage((events[key] / page_views[key].to_f) * 100, precision: 0)
    end

    result
  end
end
