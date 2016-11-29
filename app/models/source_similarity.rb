class SourceSimilarity < ActiveRecord::Base
  
  def target_source
    Source.where( 'id' => self.target_source_id ).first
  end
end
