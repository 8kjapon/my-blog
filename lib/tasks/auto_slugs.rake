namespace :articles do
  desc "自動で記事にスラッグを設定"
  task auto_slugs: :environment do
    # friendly_idで自動的にスラッグを生成
    Article.find_each(&:save!)
  end
end
