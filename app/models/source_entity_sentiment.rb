class SourceEntitySentiment < ActiveRecord::Base
  
  belongs_to :source
  belongs_to :entity
  
  def sentiment
    '%.3f' % self.average_sentiment_1
  end
  def subjectivity
    '%.3f' % self.average_sentiment_2
  end
end
