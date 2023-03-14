# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module User
        module Auth
          module Meta
            TRACK = 'user/auth'

            UNLOCALIZED_PATH = {
              pl: 'zaloguj',
              en: 'sign-in',
            }.freeze

            UNLOCALIZED_TITLE = {
              pl: 'Zaloguj',
              en: 'Sign In',
            }.freeze

            private

            def track
              @track ||= TRACK
            end

            def unlocalized_path
              @unlocalized_path ||= UNLOCALIZED_PATH
            end

            def unlocalized_title
              @unlocalized_title ||= UNLOCALIZED_TITLE
            end

            def unlocalized_keywords
              @unlocalized_keywords ||= {
                pl: "zaloguj, logowanie, konto, użytkownik, #{MAPAWYNAJMU_PL_NAME}, ogłoszenia, wynajem, nieruchomości, warszawa",
                en: "sign in, log in, account, user, #{MAPAWYNAJMU_PL_NAME}, announcement, lease, real estate, warsaw",
              }.freeze
            end

            def unlocalized_description
              @unlocalized_description ||= {
                pl: "Logowanie do konta na #{MAPAWYNAJMU_PL_NAME} - serwisu z ogłoszeniami wynajmu nieruchomości w Warszawie.",
                en: "Sign in to #{MAPAWYNAJMU_PL_NAME} - a service featuring real estate lease announcements in Warsaw.",
              }.freeze
            end

            def render
              {
                visitor: true,
                user: true,
                'user/auth': true,
              }
            end

            def links
              {
                'current/pl': ::SkillfindTech::Api::Tracks::User::Auth::Linker.new(:pl).call,
                'current/en': ::SkillfindTech::Api::Tracks::User::Auth::Linker.new(:en).call,
              }
            end
          end
        end
      end
    end
  end
end
