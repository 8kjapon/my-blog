class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :prepare_meta_tags

  def prepare_meta_tags(options = {})
    site_name = "8kjapon.com"
    title = "8kjaponですよ"
    description = "8kjaponの生息地"
    current_url = request.original_url

    defaults = {
      site: site_name,
      title: title,
      description: description,
      keywords: ['blog', 'IT', 'Programming', 'Computer', 'ブログ', 'プログラミング'],
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        description: description,
        type: "website",
        image: view_context.asset_url("icon.png")
      }
    }
    options.reverse_merge!(defaults)

    set_meta_tags(options)
  end
end
