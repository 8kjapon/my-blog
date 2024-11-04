class PagesController < ApplicationController
  def top
    @articles = Article.all
  end
end
