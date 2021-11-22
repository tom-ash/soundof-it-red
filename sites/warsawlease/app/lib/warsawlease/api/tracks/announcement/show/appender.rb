# frozen_string_literal: true

module Warsawlease
  module Api
    module Tracks
      module Announcement
        module Show
          class Appender
            include ::Api::Tracks::Helpers::Appender
            include ::Warsawlease::Api::Tracks::Announcement::Show::Meta

            def call
              merge_state
              merge_meta
            end

            private

            def merge_state
              state.merge!(
                'announcement/show/data': ::Warsawlease::Serializers::Announcement::Show.new(announcement).call
              )
            end

            def merge_meta
              meta.merge!(
                title: '123',
                keywords: '456',
                description: '789'
              )
            end

            def announcement
              @announcement ||= ::Warsawlease::Queries::Announcement::ById.new(id: announcement_id).call
            end

            def announcement_id
              @announcement_id ||= attrs[:url].match(/(\d+)-.*-(na-wynajem-warszawa|for-lease-warsaw)-.*$/)[1]
            end
          end
        end
      end
    end
  end
end