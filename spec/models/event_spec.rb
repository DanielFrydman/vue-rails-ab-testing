# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Event, type: :model) do
  describe '#in_period' do
    let!(:event) { create(:event) }

    it 'return events in period' do
      elements = Event.in_period(Time.zone.yesterday, Time.zone.tomorrow)
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

  describe '#total_uniq_events_in_period_by_displayed_text_variation_and_action' do
    let!(:event) do
      create(:event, displayed_text_variation: 'Random text.')
    end

    it 'return total uniq events in period by text variation and action' do
      hash = Event.total_uniq_events_in_period_by_displayed_text_variation_and_action(
        event_name: 'sign_up',
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
