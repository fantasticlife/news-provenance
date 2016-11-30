class Article < ActiveRecord::Base
  
  belongs_to :source
  has_many :extracted_entities
  has_many :entities, -> { order 'name' }, :through => :extracted_entities
  
  def article_similarities
    ArticleSimilarity.all.where( 'source_article_id' => self ).order( 'similarity_score desc')
  end
end
