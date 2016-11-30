class SourceEntitiesController < ApplicationController
  
  def index
    source = params[:source]
    @source = Source.find( source )
    @entities = @source.entities
    unless @entities.empty?
      @min_count = @entities.last.count
      @max_count = @entities.first.count
      @entities = @entities.sort_by { |e| e.name }
    end
    @section = 'sources'
  end
  def show
    source = params[:source]
    entity = params[:entity]
    @source = Source.find( source )
    @entity = Entity.find( entity )
    @section = 'sources'
  end
end
