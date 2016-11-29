class ArticlesController < ApplicationController
  
  def index
    @section = 'articles'
    @articles = Article.all.order( 'published_at desc' )
    @article_similarities = ArticleSimilarity.all
  end
  
  def by_url
    url = params[:url]
    @article = Article.find_by_url( url )
    #render :template => 'articles/show'
    
    respond_to do |format|
      format.json do
        render :json => @article.article_similarities.to_json( :include => :target_article )
      end
    end
  end
  
  def show
    @section = 'articles'
    article = params[:article]
    @article = Article.find( article )
  end
end
