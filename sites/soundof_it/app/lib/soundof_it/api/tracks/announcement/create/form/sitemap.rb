# frozen_string_literal: true

module SoundofIt
  module Api
    module Tracks
      module Announcement
        module Create
          module Form
            class Sitemap
              class << self
                include ::SoundofIt::Api::Tracks::Announcement::Create::Form::Meta

                def get
                  [links]
                end

                private

                def links
                  [
                    { path: unlocalized_path[:en], lang: :en, changefreq: 'monthly', priority: '1.0' }
                  ]
                end
              end
            end
          end
        end
      end
    end
  end
end