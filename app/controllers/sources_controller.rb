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
  end
end
