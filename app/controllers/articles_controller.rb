class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[show]

  def show
    @article = Article.find(params[:id])
  end
end
