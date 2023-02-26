# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Visitor
        module CookiesPolicy
          class Linker
            include ::Api::Tracks::Helpers::Linker
            include ::SkillfindTech::Api::Tracks::Visitor::CookiesPolicy::Meta
          end
        end
      end
    end
  end
end