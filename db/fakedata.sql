insert into sources (title, url) values ('Daily Mail', 'http://www.dailymail.co.uk/home/index.html');
insert into sources (title, url) values ('Daily Express', 'http://www.express.co.uk/');
insert into sources (title, url) values ('Infowars', 'http://www.infowars.com/');
	
	
insert into articles (title, url, synopsis, published_at, sentiment_1, sentiment_2, source_id) values ('Transexuals take to the stage', 'http://www.dailymail.co.uk/blah', 'some shit', '2001-09-28 01:00:00', 1.2, 1.4, 1);
	
insert into articles (title, url, synopsis, published_at, sentiment_1, sentiment_2, source_id) values ('Transexuals take to the bathrooms', 'http://www.express.co.uk/blah-blah', 'some more shit', '2001-09-29 01:00:00', 1.4, 1.1, 2);

insert into articles (title, url, synopsis, published_at, sentiment_1, sentiment_2, source_id) values ('Transexuals take to the guns', 'http://www.infowars.com/blah-blah', 'some more gun shit', '2001-10-29 01:00:00', 1.4, 1.1, 2);
	
insert into article_similarities (source_article_id, target_article_id, similarity_score) values (1, 2, 0.03);
insert into article_similarities (source_article_id, target_article_id, similarity_score) values (1, 3, 0.5);
	
insert into source_similarities (source_source_id, target_source_id, similarity_score) values (1, 2, 0.5);
insert into source_similarities (source_source_id, target_source_id, similarity_score) values (1, 3, 0.5);
	
insert into entities (name) values ('cat');
insert into entities (name) values ('dog');
insert into entities (name) values ('fish');
	
insert into extracted_entities (article_id, entity_id, score) values (1, 1, 0.7);
insert into extracted_entities (article_id, entity_id, score) values (2, 1, 0.7);
insert into extracted_entities (article_id, entity_id, score) values (3, 1, 0.7);
insert into extracted_entities (article_id, entity_id, score) values (2, 2, 0.7);
insert into extracted_entities (article_id, entity_id, score) values (3, 2, 0.7);
insert into extracted_entities (article_id, entity_id, score) values (1, 3, 0.7);