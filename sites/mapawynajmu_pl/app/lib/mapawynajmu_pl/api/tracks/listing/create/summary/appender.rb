# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Listing
        module Create
          module Summary
            class Appender < ::MapawynajmuPl::Api::Tracks::Common::Appender
              include ::MapawynajmuPl::Api::Tracks::Listing::Create::Summary::Meta

              private

              def texts
                {
                  pl: {
                    promoteButtonLabel: 'Wyróżnij ogłoszenie za 19 PLN',

                  },
                  en: {
                    promoteButtonLabel: 'Promote listing for 19 PLN',
                  },
                }[lang]
              end

              def data
                {
                  announcement: ::MapawynajmuPl::Serializers::Listing::Show.new(announcement).call.merge(
                    path: announcement.url(lang),
                    title: announcement.title(lang),
                  ),
                }
              end
            end
          end
        end
      end
    end
  end
end
