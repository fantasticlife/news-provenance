class ArticleSimilarity < ActiveRecord::Base
  
  def target_article
    Article.where( 'id' => self.target_article_id ).first
  end
end
