# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageView, type: :model do
  describe '#in_period' do
    let!(:page_view) { create(:page_view) }

    it 'return page views in period' do
      elements = PageView.in_period(Time.zone.yesterday, Time.zone.tomorrow)
      expect(elements.count).to(eq(1))
      expect(elements.last).to(eq(page_view))
    end
  end

  describe '#total_uniq_events_in_period_by_displayed_text_variation_and_action' do
    let!(:page_view) do
      create(:page_view, displayed_text_variation: 'Random text.')
    end

    it 'return total uniq events in period by text variation and action' do
      hash = PageView.total_uniq_page_views_in_period_by_displayed_text_variation(
        start_date: Time.zone.yesterday,
        end_date: Time.zone.tomorrow
      )
      expect(hash).to(
        eq(
          { 'Random text.' => 1 }
        )
      )
    end
  end
end
