# frozen_string_literal: true

class PageViewsBarChartPresenter < BarChartPresenter
  def initialize(hash)
    super(
      hash:,
      chart_title: 'Page Views Chart',
      chart_subtitle: 'Unique page views per user by text variation in period'
    )
  end
end
