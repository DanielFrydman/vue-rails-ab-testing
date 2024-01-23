# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Event, type: :model) do
  let(:yesterday) { Time.zone.yesterday.to_s }
  let(:tomorrow) { Time.zone.tomorrow.to_s }

  describe '#in_period' do
    let!(:event) { create(:event) }

    it 'return events in period' do
      elements = Event.in_period(yesterday, tomorrow)
      expect(elements.count).to(eq(1))
      expect(elements.last).to(eq(event))
    end
  end

  describe '#by_event_name' do
    let!(:event) { create(:event) }

    it 'return events by event name' do
      elements = Event.by_event_name('sign_up')
      expect(elements.count).to(eq(1))
      expect(elements.last).to(eq(event))
    end
  end

  describe '#in_period_by_displayed_text_variation_and_action' do
    let!(:event) do
      create(:event, displayed_text_variation: 'Random text.', url: 'https://fake-url.com')
    end

    it 'return a hash with total, unique and url' do
      hash = Event.in_period_by_displayed_text_variation_and_action(
        event_name: 'sign_up',
        start_date: yesterday,
        end_date: tomorrow
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
