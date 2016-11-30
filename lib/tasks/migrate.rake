task :migrate => :environment do
  articles = Article.all
  articles.each do |article|
    puts article.title
  end
end
task :import => :environment do
  puts "importing data"
  file = File.read('db/news.json')
  json = JSON.parse( file )
  json.each do |article_element|
    source_title = article_element['source_name']
    source = Source.where( :title => source_title ).first
    unless source
      source = Source.new
      source.title = source_title
      source.save
    end
    article = Article.new
    article.title = article_element['title']
    article.url = article_element['url']
    article.published_at = article_element['published']
    article.sentiment_1 = article_element['sentiment_polarity']
    article.sentiment_2 = article_element['sentiment_subjectivity']
    article.source = source
    article.save
    article_element['concepts'].each do |concept|
      entity = Entity.where( :name => concept[0] ).first
      unless entity
        entity = Entity.new
        entity.name = concept[0]
        entity.save
      end
      extracted_entity = ExtractedEntity.new
      extracted_entity.article = article
      extracted_entity.entity = entity
      extracted_entity.score = concept[1]
      extracted_entity.save
    end
  end
  puts "importing article similarities"
  source_index = 0
  json.each do |article_element|
    source_index = source_index + 1
    article_element['similar_docs'].each do |similar|
      target_index =  similar[0] + 1
      article_similarity = ArticleSimilarity.new
      article_similarity.source_article_id = source_index
      article_similarity.target_article_id = target_index
      article_similarity.similarity_score = similar[1]
      article_similarity.save
    end
  end
end