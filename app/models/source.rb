class Source < ActiveRecord::Base
  
  has_many :articles,-> { order "published_at desc" }
  
  def source_similarities
    SourceSimilarity.all.where( 'source_source_id' => self ).order( 'similarity_score desc')
  end
end
