module Admin
  class StaticPagesController < BaseController
    layout 'admin'

    def index
      @static_pages = current_user.static_pages.order(created_at: :desc)
    end

    def new
      @static_page = StaticPage.new
    end

    def edit
      @static_page = StaticPage.find(params[:id])
    end

    def create
      @static_page = current_user.static_pages.build(static_page_params)
      if @static_page.save
        redirect_to admin_dashboard_path
      else
        render :new
      end
    end

    def update
      @static_page = StaticPage.find(params[:id])
      if @static_page.update(static_page_params)
        redirect_to admin_static_pages_path
      else
        render :edit
      end
    end

    def destroy
      @static_page = StaticPage.find(params[:id])
      @static_page.destroy
      redirect_to admin_static_pages_path
    end

    private

    def static_page_params
      params.require(:static_page).permit(:title, :content)
    end
  end
end
