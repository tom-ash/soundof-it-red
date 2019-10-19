module AnnouncementsDestroy
  def destroy
    return render_bad_request unless user_validated?

    Announcement.find_by_id(params[:id]).destroy
    render json: {}
  end
end