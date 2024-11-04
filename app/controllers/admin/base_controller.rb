class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :check_if_admin

  private

  def not_authenticated
    redirect_to login_path
  end

  def check_if_admin
    unless current_user&.admin?
      redirect_to root_path
    end
  end
end