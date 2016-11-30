class Entity < ActiveRecord::Base
  
  has_many :extracted_entities
  
  def articles
    Article.all
      .select( 'articles.*')
      .joins( 'as articles, extracted_entities')
      .where( "articles.id = extracted_entities.article_id and extracted_entities.entity_id = ? and extracted_entities.score > ?", self, 0.6)
      .order( 'published_at desc' )
  end
  def source_articles( source )
    Article.select( 'articles.*' )
      .joins( 'as articles, extracted_entities' )
      .where( "extracted_entities.article_id = articles.id and extracted_entities.entity_id = ? and articles.source_id = ? and extracted_entities.score > ?", self, source, 0.6 )
  end
  def cooccurrent_entities
    Entity.find_by_sql( "SELECT e.*, ij.count 
      FROM entities e
      INNER JOIN (
        SELECT ee2.entity_id, count(ee2.article_id) as count 
        FROM extracted_entities ee1, extracted_entities ee2 
        WHERE ee1.entity_id = #{self.id}
        AND ee1.entity_id != ee2.entity_id
        AND ee1.article_id = ee2.article_id
        AND ee1.score > 0.6
        AND ee2.score > 0.6
        GROUP by ee2.entity_id
        ORDER by count desc 
      ) as ij
      ON ij.entity_id = e.id
      ORDER BY count desc, e.name
      LIMIT 20;"
    )
  end
end