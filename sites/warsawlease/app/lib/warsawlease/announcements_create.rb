# frozen_string_literal: true

module Warsawlease
  module AnnouncementsCreate
    def create
      return bad_request unless user_validated?
      return bad_request if @user.status == 2

      prepare_announcement_object
      handle_rent_amount
      handle_availability_date
      create_announcement
      handle_pictures
      @response = { id: @announcement.id }
      created
    end

    private

    def prepare_announcement_object
      @announcement_object = preparatory_announcement_object
      create_attributes.each { |attribute| @announcement_object[attribute] = params[attribute] }
    end

    def preparatory_announcement_object
      {
        user_id: @user.id,
        status: 1,
        points: 0,
        views: 0,
        reports: [],
        visible: true,
        active_until: Date.today + 60.days,
        change_log: []
      }
    end

    def create_announcement
      @announcement = Announcement.create(@announcement_object)
    end

    def create_attributes
      AnnouncementsAttributes::CREATE
    end

    def handle_pictures
      params[:pictures].each do |picture|
        PersistedObject.new("temporary/#{picture[:database]}").move_to(
          "announcements/#{@announcement.id}/#{picture[:database]}"
        )
      end
    end
  end
end