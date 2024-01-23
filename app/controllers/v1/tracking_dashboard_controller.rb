# frozen_string_literal: true

module V1
  class TrackingDashboardController < ApplicationController
    def index
      page_views_chart = PageViewsBarChartPresenter.new(total_uniq_page_views).chart_data
      events_chart = EventsBarChartPresenter.new(hash: total_uniq_events, event_name:).chart_data
      ctr_chart = ClickthroughRateBarChartPresenter.new(
        total_uniq_page_views:,
        total_uniq_events:
      ).chart_data

      render json: { page_views_chart:, events_chart:, ctr_chart: }, status: :ok
    rescue StandardError => e
      render json: { message: "An error occured: #{e}." }, status: :internal_server_error
    end

    def list_event_names
      render json: { event_names: Event.pluck(:event_name).uniq }, status: :ok
    rescue StandardError => e
      render json: { message: "An error occured: #{e}." }, status: :internal_server_error
    end

    private

    def total_uniq_page_views
      @total_uniq_page_views ||= PageView.total_uniq_page_views_in_period_by_displayed_text_variation(
        start_date:, end_date:
      )
    end

    def total_uniq_events
      @total_uniq_events ||= Event.total_uniq_events_in_period_by_displayed_text_variation_and_action(
        event_name:, start_date:, end_date:
      )
    end

    def start_date
      params.require(:start_date)
    end

    def end_date
      params.require(:end_date)
    end

    def event_name
      params.require(:event_name)
    end
  end
end
