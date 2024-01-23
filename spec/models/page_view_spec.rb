# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(PageView, type: :model) do
  let(:yesterday) { Time.zone.yesterday.to_s }
  let(:tomorrow) { Time.zone.tomorrow.to_s }

  describe '#in_period' do
    let!(:page_view) { create(:page_view) }

    it 'return page views in period' do
      elements = PageView.in_period(yesterday, tomorrow)
      expect(elements.count).to(eq(1))
      expect(elements.last).to(eq(page_view))
    end
  end

  describe '#by_url' do
    let!(:page_view) { create(:page_view, url: 'https://fake-url.com') }

    it 'return events by event name' do
      elements = PageView.by_url('https://fake-url.com')
      expect(elements.count).to(eq(1))
      expect(elements.last).to(eq(page_view))
    end
  end

  describe '#in_period_by_displayed_text_variation_and_url' do
    let!(:page_view) do
      create(:page_view, displayed_text_variation: 'Random text.', url: 'https://fake-url.com')
    end

    it 'return a hash with total, unique and url' do
      hash = PageView.in_period_by_displayed_text_variation_and_url(
        start_date: yesterday,
        end_date: tomorrow,
        url: 'https://fake-url.com'
      )
      expect(hash).to(
        eq(
          {
            total: { 'Random text.' => 1 },
            unique: { 'Random text.' => 1 },
            url: 'https://fake-url.com'
          }
        )
      )
    end
  end
end
