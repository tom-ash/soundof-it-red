# frozen_string_literal: true

module MapawynajmuPl
  module Api
    module Announcement
      module Create
        class AsUser < Grape::API
          helpers MapawynajmuPl::Api::Announcement::Helpers::Attrs

          before { authorize! }

          params { use :announcement_attrs }
          post do
            announcement_attrs = { user_id: current_user.id, attrs: params[:announcement].merge(confirmed: true) }
            ::MapawynajmuPl::Commands::Announcement::Create.new(announcement_attrs).call
            current_user.announcements.last.summary_path(lang)
          end
        end
      end
    end
  end
end
