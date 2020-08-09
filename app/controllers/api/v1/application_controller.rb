class Api::V1::ApplicationController < ActionController::Base

  before_action :authorize

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_not_found

  private

  def authorize
    user = params[:user]
    password = params[:password]
    unless user == ENV['AUTH_USER'] && password == ENV['AUTH_PASSWORD']
      head :unauthorized
    end
  end

  def rescue_with_not_found
    head :not_found
  end
end
