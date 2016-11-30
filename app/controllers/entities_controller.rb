class EntitiesController < ApplicationController
  
  def index
    @entities = Entity.select( "entities.*, count(extracted_entities.id) as count" )
              .from( "entities, extracted_entities" )
              .where( "entities.id = extracted_entities.entity_id and extracted_entities.score > ?", 0.6 )
              .having( "count(entities.id) > 1" )
              .group( "entities.id" )
              .order( "count(entities.id) desc")
              .limit( 200 )
    unless @entities.empty?
      @min_count = @entities.last.count
      @max_count = @entities.first.count
      @entities = @entities.sort_by { |e| e.name }
    end
    @section = 'entities'
  end
  
  def show
    entity = params[:entity]
    @entity = Entity.find( entity )
    @cooccurrent_entities = @entity.cooccurrent_entities
    unless @cooccurrent_entities.empty?
      @min_count = @cooccurrent_entities.last.count
      @max_count = @cooccurrent_entities.first.count
      @cooccurrent_entities = @cooccurrent_entities.sort_by { |e| e.name }
    end
    @section = 'entities'
  end
end
