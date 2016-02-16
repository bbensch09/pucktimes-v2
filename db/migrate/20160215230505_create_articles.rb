class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.date :published
      t.string :article_content

      t.timestamps null: false
    end
  end
end
