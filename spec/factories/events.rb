# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    user_id { '123' }
    event_name { 'sign_up' }
    url { Faker::Internet.url }
    displayed_text_variation { Faker::ChuckNorris.fact }
  end
end
