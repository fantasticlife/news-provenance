class SourcesController < ApplicationController
  
  def index
    @section = 'sources'
    @sources = Source.all.order( :title )
    @source_similarities = SourceSimilarity.all
  end
  def show
    @section = 'sources'
    source = params[:source]
    @source = Source.find(source)
    @entities = @source.entities
    unless @entities.empty?
      @min_count = @entities.last.count
      @max_count = @entities.first.count
      @entities = @entities.sort_by { |e| e.name }
    end
  end
  def sources_list
    @section = 'sources'
    source = params[:source]
    @source = Source.find(source)
  end
  def articles_list
    @section = 'sources'
    source = params[:source]
    @source = Source.find(source)
  end
end
