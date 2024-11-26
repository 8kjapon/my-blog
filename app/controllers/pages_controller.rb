class PagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  def top
    @articles = Article.all
  end
end
