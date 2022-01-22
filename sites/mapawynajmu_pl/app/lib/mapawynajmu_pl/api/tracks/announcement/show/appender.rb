# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Announcement
        module Show
          class Appender
            include ::Api::Tracks::Helpers::Appender
            include ::MapawynajmuPl::Api::Tracks::Announcement::Show::Meta

            private

            def merge_state
              state.merge!(
                'announcement/show/data': ::MapawynajmuPl::Serializers::Announcement::Show.new(announcement).call
              )
            end

            def merge_meta
              meta.merge!(
                title: announcement.title(lang),
                keywords: announcement.keywords(lang),
                description: announcement.description(lang),
                image: announcement.image,
                canonical_url: url
              )
            end

            def announcement
              @announcement ||= ::MapawynajmuPl::Queries::Announcement::ById.new(id: announcement_id).call
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