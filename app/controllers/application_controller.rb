class ApplicationController < ActionController::API
  before_action :snakelize_params

  private

  def snakelize_params
    params.transform_keys!(&:underscore)
  end

  def required_params_present?
    @required_params.each { |param| return unless params[param] }
  end
end
