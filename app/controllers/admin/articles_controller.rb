class Admin::ArticlesController < Admin::BaseController
  layout 'admin'

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to admin_dashboards_path
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
