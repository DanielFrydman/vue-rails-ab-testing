# frozen_string_literal: true

FactoryBot.define do
  factory :page_view do
    user_id { '123' }
    url { Faker::Internet.url }
    displayed_text_variation { Faker::ChuckNorris.fact }
  end
end
