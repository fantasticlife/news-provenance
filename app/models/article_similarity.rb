class ArticleSimilarity < ActiveRecord::Base
  
  def target_article
    Article.where( 'id' => self.target_article_id ).first
  end
  def similarity
    '%.3f' % self.similarity_score
  end
  def sentiment
    '%.3f' % self.sentiment_1
  end
  def subjectivity
    '%.3f' % self.sentiment_2
  end
end
