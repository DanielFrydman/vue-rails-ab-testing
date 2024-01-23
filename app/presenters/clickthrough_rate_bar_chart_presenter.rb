# frozen_string_literal: true

class ClickthroughRateBarChartPresenter < BarChartPresenter
  def initialize(total_uniq_page_views:, total_uniq_events:)
    super(
      hash: calculate_ctrs(total_uniq_page_views, total_uniq_events),
      chart_title: 'CTR Chart',
      chart_subtitle: 'Clickthrough Rate per unique users by text variation in period (%)'
    )
  end

  private

  def calculate_ctrs(page_views, events)
    result = {}

    page_views.each_key do |key|
      return result[key] = nil if events[key].nil? || page_views[key].zero?

      result[key] = (events[key] / page_views[key].to_f) * 100
    end

    result
  end
end
