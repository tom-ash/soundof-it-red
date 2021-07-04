# frozen_string_literal: true

module Warsawlease
  module Queries
    module Announcement
      module Index
        class Visitor
          CATEGORY_VALUES = {
            'apartments': 2, 'houses': 3, 'rooms': 4, 'parking-spaces': 5,
            'usable-premises': 1, 'offices': 0, 'virtual-offices': 6, 'coworking': 7
          }.freeze

          def initialize(category: nil)
            @category = category
          end

          def call
            announcements
          end

          private

          attr_reader :category

          def announcements
            ::Warsawlease::Announcement.where(search_params).order('points DESC').order('active_until DESC')
          end

          def search_params
            shared_search_params.merge(category_search_params)
          end

          def shared_search_params
            { visible: true, confirmed: true }
          end

          def category_search_params
            return {} if category.blank?

            { category: CATEGORY_VALUES[category.to_sym] }
          end
        end
      end
    end
  end
end