# frozen_string_literal: true

module SkillfindTech
  module Api
    module Tracks
      module Visitor
        module Contact
          class Appender
            include ::Api::Tracks::Helpers::Appender
            include ::SkillfindTech::Api::Tracks::Visitor::Contact::Meta
          end
        end
      end
    end
  end
end