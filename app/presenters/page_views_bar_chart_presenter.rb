# frozen_string_literal: true

class PageViewsBarChartPresenter < BarChartPresenter
  def initialize(hash:, title:, subtitle:)
    super(
      hash:,
      chart_title: title,
      chart_subtitle: subtitle
    )
  end
end
