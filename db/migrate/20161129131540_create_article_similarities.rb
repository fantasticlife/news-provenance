class CreateArticleSimilarities < ActiveRecord::Migration
  def change
    create_table :article_similarities do |t|

      t.timestamps null: false
    end
  end
end
