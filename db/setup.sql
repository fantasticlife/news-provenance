drop table if exists extracted_entities;
drop table if exists entities;
drop table if exists article_similarities;
drop table if exists articles;
drop table if exists source_similarities;
drop table if exists sources;

create table sources (
	id serial,
	title varchar(255) not null,
	primary key (id)
);
create table source_similarities (
	id serial,
	source_source_id int not null,
	target_source_id int not null,
	similarity_score float,
	constraint fk_source_source foreign key (source_source_id) references sources(id),
	constraint fk_target_source foreign key (target_source_id) references sources(id),
	primary key (id)
);
create table articles (
	id serial,
	title varchar(255) not null,
	url varchar(255),
	published_at timestamp,
	sentiment_1 float,
	sentiment_2 float,
	source_id int not null,
	constraint fk_source foreign key (source_id) references sources(id),
	primary key (id)
);
create table article_similarities (
	id serial,
	source_article_id int not null,
	target_article_id int not null,
	similarity_score float,
	constraint fk_source_article foreign key (source_article_id) references articles(id),
	constraint fk_target_article foreign key (target_article_id) references articles(id),
	primary key (id)
);
create table entities (
	id serial,
	name varchar(255) not null,
	primary key (id)
);
create table extracted_entities (
	id serial,
	article_id int not null,
	entity_id int not null,
	score float,
	constraint fk_extracted_entity_article foreign key (article_id) references articles(id),
	constraint fk_extracted_entity_entity foreign key (entity_id) references entities(id),
	primary key (id)
);