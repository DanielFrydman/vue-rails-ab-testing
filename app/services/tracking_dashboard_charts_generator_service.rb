# frozen_string_literal: true

class TrackingDashboardChartsGeneratorService
  def initialize(start_date:, end_date:, event_name:)
    @event_name = event_name
    @events = Event.in_period_by_displayed_text_variation_and_action(
      event_name:, start_date:, end_date:
    )
    @page_views = PageView.in_period_by_displayed_text_variation_and_url(
      start_date:, end_date:, url: @events[:url]
    )
  end

  def generate
    {
      unique_events_chart:,
      unique_page_views_chart:,
      unique_ctr_chart:,
      total_events_chart:,
      total_page_views_chart:,
      total_ctr_chart:
    }
  end

  private

  def unique_events_chart
    @formatted_event_name ||= @event_name.gsub('_', ' ').capitalize
    EventsBarChartPresenter.new(
      hash: @events[:unique],
      title: "Unique #{@formatted_event_name} Chart",
      subtitle: "Unique #{@formatted_event_name} events per user by text variation in period"
    ).chart_data
  end

  def unique_page_views_chart
    PageViewsBarChartPresenter.new(
      hash: @page_views[:unique],
      title: 'Unique Page Views Chart',
      subtitle: 'Unique page views per user by text variation in period'
    ).chart_data
  end

  def unique_ctr_chart
    ClickthroughRateBarChartPresenter.new(
      total_page_views: @page_views[:unique],
      total_events: @events[:unique],
      title: 'Unique CTR Chart',
      subtitle: 'Unique clickthrough rate per users by text variation in period (%)'
    ).chart_data
  end

  def total_events_chart
    @formatted_event_name ||= @event_name.gsub('_', ' ').capitalize
    EventsBarChartPresenter.new(
      hash: @events[:total],
      title: "Total #{@formatted_event_name} Chart",
      subtitle: "Total #{@formatted_event_name} events by text variation in period"
    ).chart_data
  end

  def total_page_views_chart
    PageViewsBarChartPresenter.new(
      hash: @page_views[:total],
      title: 'Total Page Views Chart',
      subtitle: 'Total page views by text variation in period'
    ).chart_data
  end

  def total_ctr_chart
    ClickthroughRateBarChartPresenter.new(
      total_page_views: @page_views[:total],
      total_events: @events[:total],
      title: 'Total CTR Chart',
      subtitle: 'Total clickthrough rate by text variation in period (%)'
    ).chart_data
  end
end
