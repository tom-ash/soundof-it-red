# frozen_string_literal: true

module Api
  module Tracks
    module Image
      module Edit
        class Appender
          include ::Api::Tracks::Helpers::Appender
          include ::Api::Tracks::Image::Edit::Meta

          private

          def merge_state
            state.merge!(
              'image/edit/data': {
                id: image_id,
                body: JSON.pretty_generate(site::Image.find(image_id).body)
              }
            )
          end

          def image_id
            @image_id ||= url.match(%r{(edit-image|edytuj-obraz)/(\d+)})[2].to_i
          end
        end
      end
    end
  end
end
