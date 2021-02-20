class RouteDataController < ApplicationController
  include Responses
  include AnnouncementsIndex
  include AnnouncementsShared
  include UsersAuthorize
  include UsersShow
  include UsersVerify
  include UsersCiphers

  def show
    route_url = request.headers['Route-Url']
    track = request.headers['Track']
    meta_data = {}
    initial_state = nil
    isSSR = request.headers['Type'] == 'ssr'
    lang = request.headers['Lang']
    page_name = request.headers['Page-Name']

    if ['root', 'announcement/index/catalogue'].include?(track)
      search_announcements

      initial_state = {
        announcements: @announcements,
        amount: @announcements.count
      }
    end

    if track == 'announcement/index/my'
      return bad_request unless user_validated?

      prepare_announcements
      limit_announcements
      sort_announcements
      select_attributes

      initial_state = {
        announcements: @announcements,
        amount: @announcements.count
      }
    end

    if route_url.match(/(\d+)-.*-(na-wynajem-warszawa|for-lease-warsaw)-.*$/)
      # TODO: REWRITE TO SERVICE BEGIN
      @announcement = Announcement.find_by(id: $1)
      return render_404 unless @announcement&.visible?

      @attributes = @announcement.attributes.slice(*AnnouncementsAttributes::SHOW_FULL)
      user = @announcement.user
      @announcement.user_id = nil
      @attributes = @attributes.as_json.with_indifferent_access
      parse_availability_date
      @attributes[:name] = user.showcase['name']
      @attributes[:phone] = user.showcase['phone']
      initial_state = { announcement: @attributes }
      # TODO: REWRITE TO SERVICE END

      meta_data = {
        title: { category: @attributes[:category], district: @attributes[:district], area: @attributes[:area] },
        description: { pl: @attributes[:polish_description], en: @attributes[:english_description] },
        keywords: { category: @attributes[:category], district: @attributes[:district] },
        image: { imageKey: "announcements/#{@attributes[:id]}/#{@attributes[:pictures][0]['database']}" }
      }
    end

    if track == 'user/edit'
      return bad_request unless user_validated?

      initial_state = {
        phone_code: @user.phone['code'],
        phone_body: @user.phone['body'],
        email: @user.email
      }.merge(account_type_specific_attributes)

    end

    page = {}
    if page_name.present?
      page = Post.find_by(name: page_name, lang: lang)
      urls = Post.where(name: page.name).pluck(:lang, :url).to_h
      page = page.slice(:name, :url, :body, :style, :title, :description, :keywords, :canonical_url, :picture, :meta, :lang).merge(lang_ver_urls: urls)
    end

    if track == 'page/edit'
      page_name_or_url = route_url.match(/^(edit-page|edytuj-strone)\/(.+)$/)[2]
      page = Post.find_by(name: page_name_or_url, lang: lang) || Post.find_by(url: page_name_or_url)
      urls = Post.where(name: page.name).pluck(:lang, :url).to_h
      page = page.slice(:name, :url, :body, :style, :title, :description, :keywords, :canonical_url, :picture, :meta, :lang).merge(lang_ver_urls: urls)
      initial_state = { 'page_create': page }
    end

    response = { metaData: meta_data, initialState: initial_state, page: page }

    if isSSR
      user_data = { 'authorized' => false, 'account_type' => nil, 'first_name' => nil, 'business_name' => nil, 'role' => nil }
      user_validated?
      authorized = @user.present?
      if authorized
        user_data.merge!(@user&.attributes&.slice('account_type', 'first_name', 'business_name', 'role')).merge!('authorized' => true)
      end

      response.merge!(user: user_data)
      response.merge!(svgs: SVG.all)
    end

    render json: response.as_json.deep_transform_keys { |key| key.to_s.camelize(:lower) }
  end
end