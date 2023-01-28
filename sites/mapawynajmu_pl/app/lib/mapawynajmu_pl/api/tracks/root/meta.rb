# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Tracks
      module Root
        module Meta
          include ::MapawynajmuPl::Api::Tracks::Announcement::Common::PartnerAndCategory

          TRACK = 'root'

          ROOT_PL = '/'
          CATEGORY_PL = "wynajem/(?<current_category_name>#{::MapawynajmuPl::Announcement::URL_CATEGORIES})$"
          PARTNER_PL = "partnerzy\/(?<current_partner_name>[^\/]*)(\/#{CATEGORY_PL})?"

          ROOT_EN = 'en'
          CATEGORY_EN = "rent/(?<current_category_name>#{::MapawynajmuPl::Announcement::URL_CATEGORIES})"
          PARTNER_EN = "partners\/(?<current_partner_name>[^\/]*)(\/#{CATEGORY_EN})?"

          UNLOCALIZED_PATH = {
            pl: /^#{ROOT_PL}|#{CATEGORY_PL}|#{PARTNER_PL}$/,
            en: /^#{ROOT_EN}|#{CATEGORY_EN}|#{PARTNER_EN}$/,
          }.freeze

          UNLOCALIZED_TITLE = {
            pl: 'Nieruchomości na wynajem',
            en: 'Properties for Rent',
          }.freeze

          private

          def track
            @track ||= TRACK
          end

          def title
            @title ||= begin
              return current_category_title if current_category.present?

              unlocalized_title[lang]
            end
          end

          def venue
            @venue ||= :map
          end

          def unlocalized_path
            @unlocalized_path ||= UNLOCALIZED_PATH
          end

          def unlocalized_title
            @unlocalized_title ||= UNLOCALIZED_TITLE
          end

          def unlocalized_keywords
            @unlocalized_keywords ||= {
              pl: 'mapa, wynajem, nieruchomości, mieszkania, bezpłatne, ogłoszenia, wynajmu, wynajęcie, wynajęcia, najmu, najem, darmo, darmowe, domy, pokoje, lokale, użytkowe, biura, wirtualne, miejsca, postojowe, coworking',
              en: 'map, lease, rent, real, estate, property, properties, apartments, free, announcements, houses, rooms, usable, premises, offices, virtual, parking, spaces, coworking',
            }.freeze
          end

          def unlocalized_description
            @unlocalized_description ||= {
              pl: 'Bezpłatne ogłoszenia wynajmu nieruchomości na mapie. Mieszkania, pokoje, lokale użytkowe, biura i inne nieruchomości na wynajem.',
              en: 'Free property rental listings on a map. Apartments, rooms, usable premises, offices, and other properties for rent.',
            }.freeze
          end

          def render
            {
              'visitor': true,
              'announcement': true,
              'announcement/index': true,
              "announcement/index/#{venue}": true,
            }
          end

          def links
            {}.merge(
              ::MapawynajmuPl::Api::Tracks::Root::Linker.new(lang, url).category_links,
              ::MapawynajmuPl::Api::Tracks::Root::Linker.new(lang, url).lang_links,
            )
          end

          def current_category_title
            "#{::MapawynajmuPl::Announcement::CATEGORIES[current_category][:name_plural][lang]} #{FOR_LEASE[lang]}"
          end
        end
      end
    end
  end
end
