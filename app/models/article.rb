class Article < ActiveRecord::Base
  
  belongs_to :source
  
  def article_similarities
    ArticleSimilarity.all.where( 'source_article_id' => self ).order( 'similarity_score desc')
  end
end
