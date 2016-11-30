class Source < ActiveRecord::Base
  
  has_many :articles,-> { order "published_at desc" }
  
  def source_similarities
    SourceSimilarity.all.where( 'source_source_id' => self ).order( 'similarity_score desc')
  end
  def entities
    Entity.select( "entities.*, count(extracted_entities.id) as count" )
      .from( "entities, extracted_entities, articles" )
      .where( "entities.id = extracted_entities.entity_id and extracted_entities.article_id = articles.id and articles.source_id = ? and extracted_entities.score > ?", self, 0.6 )
      .having( "count(entities.id) > 1" )
      .group( "entities.id" )
      .order( "count(entities.id) desc")
      .limit( 200 )
  end
end
