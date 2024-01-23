# frozen_string_literal: true

module UniqueUserCountByTextVariation
  extend ActiveSupport::Concern

  module ClassMethods
    def unique_user_count_by_text_variation(text_variations, collection)
      hash = {}
      text_variations.each do |text_variation|
        new_collection = collection.select { |element| element.displayed_text_variation == text_variation }
        hash[text_variation] = new_collection.pluck(:user_id).uniq.count
      end
      hash
    end
  end
end
