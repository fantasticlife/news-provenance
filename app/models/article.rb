class Article < ActiveRecord::Base
  
  belongs_to :source
  has_many :extracted_entities
  has_many :entities, -> { order 'name' }, :through => :extracted_entities
  
  def article_similarities
    ArticleSimilarity.all
      .select( 'article_similarities.*, articles.published_at as published_at, articles.title as title, articles.sentiment_1 as sentiment_1, articles.sentiment_2 as sentiment_2' )
      .joins( 'article_similarities, articles')
      .where( "article_similarities.target_article_id = articles.id and article_similarities.source_article_id = ?", self )
      .order( 'similarity_score desc')
  end
  def sentiment
    '%.3f' % self.sentiment_1
  end
  def subjectivity
    '%.3f' % self.sentiment_2
  end
  def ordered_article_similarities( order )
    ordered_article_similarities = self.article_similarities
    if order == 'similarity'
      ordered_article_similarities = ordered_article_similarities.sort_by{ |as| -as[:similarity_score] }
    elsif order == 'sentiment'
      ordered_article_similarities = ordered_article_similarities.sort_by{ |as| -as[:sentiment_1] }
    elsif order == 'subjectivity'
      ordered_article_similarities = ordered_article_similarities.sort_by{ |as| -as[:sentiment_2] }
    end
    ordered_article_similarities
  end
end
