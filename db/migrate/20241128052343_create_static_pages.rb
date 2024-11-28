class CreateStaticPages < ActiveRecord::Migration[7.0]
  def change
    create_table :static_pages do |t|
      t.string :title, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_column :static_pages, :content, :text
  end
end
