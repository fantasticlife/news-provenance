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
task :import_source_similarities => :environment do
  file = File.read('db/sources.json')
  json = JSON.parse( file )
  json.each do |article|
    source_source_name = article[1]['source_name']
    source_source = Source.where( :title => source_source_name ).first
    article[1]['similar'].each do |similar|
      target_source_name = similar[1]
      target_source = Source.where( :title => target_source_name ).first
      source_similarity = SourceSimilarity.new
      source_similarity.source_source_id = source_source.id
      source_similarity.target_source_id = target_source.id
      source_similarity.similarity_score = similar[2]
      source_similarity.save
    end
  end
end
task :remove_noisy_entity_extraction => :environment do
  extracted_entities = ExtractedEntity.all.where( 'score < 0.6' )
  extracted_entities.each do |extracted_entity|
    extracted_entity.destroy
  end
  entities = Entity.all
  entities.each do |entity|
    entity.destroy if entity.extracted_entities.empty?
  end
end
task :populate_source_entity_sentiments => :environment do
  puts "importing source entity sentiments"
  entities = Entity.all.order( 'name' )
  entities.each do |entity|
    puts entity.name
    sources = Source.all
    sources.each do |source|
      article_count = 0
      total_sentiment_1_count = 0.0
      total_sentiment_2_count = 0.0
      articles = Article.all
        .joins( 'as articles, extracted_entities as extracted_entities' )
        .where( "articles.source_id = ? and articles.id = extracted_entities.article_id and extracted_entities.entity_id = ? and extracted_entities.score > ?", source.id, entity.id, 0.6 )
      unless articles.empty?
        article_count = articles.size
        articles.each do |article|
          total_sentiment_1_count = total_sentiment_1_count + article.sentiment_1
          total_sentiment_2_count = total_sentiment_2_count + article.sentiment_2
        end
        average_sentiment_1 = total_sentiment_1_count / article_count
        average_sentiment_2 = total_sentiment_2_count / article_count
        source_entity_sentiments = SourceEntitySentiment.new
        source_entity_sentiments.source = source
        source_entity_sentiments.entity = entity
        source_entity_sentiments.article_count = article_count
        source_entity_sentiments.average_sentiment_1 = average_sentiment_1
        source_entity_sentiments.average_sentiment_2 = average_sentiment_2
        source_entity_sentiments.save
      end
    end
  end
end