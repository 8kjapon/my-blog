class PagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  def top
    @articles = Article.order(created_at: :desc)
  end

  def portfolio
    @static_page = StaticPage.find_by(title: "portfolio")
  end
end
