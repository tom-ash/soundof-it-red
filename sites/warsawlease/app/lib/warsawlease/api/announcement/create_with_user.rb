# frozen_string_literal: true

module Warsawlease
  module Api
    module Announcement
      class CreateWithUser < Grape::API
        helpers Warsawlease::Api::Announcement::Helpers::Attrs
        helpers Warsawlease::Api::User::Helpers::Attrs

        params do
          use :announcement_attrs
          use :user_attrs
        end
        post do
          ::Commands::User::Create::EmailAndPassword.new(params[:user].merge(site_name: site_name)).call
          user = Warsawlease::User.find_by!(email: params[:user][:email])
          announcement_attrs = { attrs: params[:announcement].merge(confirmed: false), user_id: user.id }
          ::Warsawlease::Commands::Announcement::Create.new(announcement_attrs).call
          ::Mailers::Verification.new(email: params[:user][:email], namespace: 'user/create/email-and-password', lang: lang, site_name: site_name).send
          nil
        end
      end
    end
  end
end
