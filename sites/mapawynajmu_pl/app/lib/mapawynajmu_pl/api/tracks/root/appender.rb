# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Root
        class Appender
          include ::Api::Tracks::Helpers::Appender
          include ::MapawynajmuPl::Api::Tracks::Root::Meta
          include ::MapawynajmuPl::Api::Tracks::Helpers::Announcements
          include ::MapawynajmuPl::Api::Tracks::Helpers::Filters

          private

          def merge_state
            state.merge!(
              'announcement/index/data': data,
              'announcement/index/inputs': inputs,
              'announcement/index/control': {
                current_tile_id: nil,
              },
            )
          end

          def data
            {
              announcements: serialized_announcements,
              amount: serialized_announcements.count,
              current_category: category,
              title: title,
              tile: nil,
            }
          end
        end
      end
    end
  end
end
