# frozen_string_literal: true

class ClickthroughRateBarChartPresenter < BarChartPresenter
  def initialize(total_page_views:, total_events:, title:, subtitle:)
    super(
      hash: calculate_ctrs(total_page_views, total_events),
      chart_title: title,
      chart_subtitle: subtitle
    )
  end

  private

  def calculate_ctrs(page_views, events)
    result = {}

    page_views.each_key do |key|
      if events[key].nil? || page_views[key].zero?
        result[key] = 0
        next
      end

      result[key] = (events[key] / page_views[key].to_f) * 100
    end

    result
  end
end
