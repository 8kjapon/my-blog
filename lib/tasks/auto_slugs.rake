namespace :articles do
  desc "自動で記事にスラッグを設定"
  task auto_slugs: :environment do
    Article.find_each do |article|
      # friendly_idで自動的にスラッグを生成
      article.save!
    end
  end
end