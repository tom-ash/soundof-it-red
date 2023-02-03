# frozen_string_literal: true

module Api
  module Tracks
    module Helpers
      module Linker
        def initialize(lang, decorators = nil)
          @lang = lang.to_sym
          @decorators = decorators
        end

        def call
          {
            href: href,
            path: path,
            title: title,
            label: label,
            href_lang: lang,
          }
        end

        private

        attr_reader :lang, :decorators

        def path
          unlocalized_path[lang]
        end

        def title
          unlocalized_title[lang]
        end

        def label
          nil
        end

        def href
          "#{protocol_and_domain}/#{path}"
        end

        def protocol_and_domain
          Rails.env.production? ? MAPAWYNAJMU_PL_URL : MAPAWYNAJMU_PL_DEV_URL
        end
      end
    end
  end
end
