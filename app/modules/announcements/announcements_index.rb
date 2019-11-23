module AnnouncementsIndex
  def index
    return list if params[:type] == 'list'

    search_announcements
    prepare_response
    ok
  end

  def list
    return bad_request unless user_validated?

    prepare_announcements
    filter_announcements
    limit_announcements
    sort_announcements
    select_attributes
    @response = { amount: @amount, announcements: @announcements.map(&:attributes).to_a }
    ok
  end

  private

  def search_announcements
    @announcements = Announcement.where(status: 1, visible: true)
    handle_equal_attributes
    handle_minimal_attributes
    handle_maximal_attributes
  end

  def handle_equal_attributes
    equal_attributes.each do |attribute|
      value = params[attribute]
      next unless value

      @announcements = @announcements.where(attribute => value)
    end
  end

  def handle_minimal_attributes
    minimal_attributes.each do |attribute|
      value = params[attribute]
      next unless value

      @announcements = @announcements.where("#{attribute[4..-1]} >= ?", value)
    end
  end

  def handle_maximal_attributes
    maximal_attributes.each do |attribute|
      value = params[attribute]
      next unless value

      attribute = attribute == :availability_date ? attribute : attribute[4..-1]
      @announcements = @announcements.where("#{attribute} <= ?", value)
    end
  end

  def prepare_response
    @response = { announcements: announcements, amount: amount }
  end

  def announcements
    @announcements.limit(per_page).offset(params[:offset]).select(full_attributes)
  end

  def amount
    @announcements.count
  end

  def prepare_announcements
    @amount = @user.announcements.count
    @announcements = @user.announcements
  end

  def filter_announcements
    filters.each do |filter|
      next if params[filter[:name]] == 'true'

      @announcements = @announcements.where.not(filter[:attribute] => filter[:value])
    end
    @amount = @announcements.count
  end

  def limit_announcements
    @announcements = @announcements.limit(10).offset!(params[:offset])
  end

  def sort_announcements
    @announcements = @announcements.order(sorters[request.headers[:sort]])
  end

  def select_attributes
    @announcements = @announcements.select(
      [*full_attributes, %i[
        views
        status
        distinct
        visible
        active_until
        created_at
        updated_at
      ]]
    )
  end

  def full_attributes
    AnnouncementsAttributes::INDEX_FULL
  end

  def equal_attributes
    AnnouncementsAttributes::INDEX_EQUAL
  end

  def minimal_attributes
    AnnouncementsAttributes::INDEX_MINIMAL
  end

  def maximal_attributes
    AnnouncementsAttributes::INDEX_MAXIMAL
  end

  def per_page
    AnnouncementsAttributes::INDEX_PER_PAGE
  end

  def filters
    AnnouncementsAttributes::INDEX_FILTERS
  end

  def sorters
    AnnouncementsAttributes::INDEX_SORTERS
  end
end
