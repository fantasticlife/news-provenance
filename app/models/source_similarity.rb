class SourceSimilarity < ActiveRecord::Base
  
  def target_source
    Source.where( 'id' => self.target_source_id ).first
  end
  def similarity
    '%.3f' % self.similarity_score
  end
end
