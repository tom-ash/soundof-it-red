# frozen_string_literal: true

module Warsawlease
  module Commands
    module User
      class Confirm
        def initialize(user_id:)
          @user_id = user_id
        end

        def call
          user.announcements.last&.update!(confirmed: true)
        end

        private

        attr_reader :user_id

        def user
          @user ||= ::Warsawlease::User.find(user_id)
        end
      end
    end
  end
end
