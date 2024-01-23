# frozen_string_literal: true

class EventsBarChartPresenter < BarChartPresenter
  def initialize(hash:, event_name:)
    formatted_event_name = event_name.gsub('_', ' ').capitalize

    super(
      hash:,
      chart_title: "#{formatted_event_name} Chart",
      chart_subtitle: "Unique #{formatted_event_name} events per user by text variation in period"
    )
  end
end
