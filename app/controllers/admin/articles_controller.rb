module Admin
  class ArticlesController < BaseController
    layout 'admin'

    def index
      @articles = current_user.articles.order(created_at: :desc)
    end

    def new
      @article = Article.new
    end

    def edit
      @article = Article.friendly.find(params[:id])
    end

    def create
      @article = current_user.articles.build(article_params)
      if @article.save
        redirect_to admin_dashboard_path
      else
        render :new
      end
    end

    def update
      @article = Article.friendly.find(params[:id])
      if @article.update(article_params)
        redirect_to admin_articles_path
      else
        render :edit
      end
    end

    def destroy
      @article = Article.friendly.find(params[:id])
      @article.destroy
      redirect_to admin_articles_path
    end

    private

    def article_params
      params.require(:article).permit(:title, :content, :slug)
    end
  end
end
