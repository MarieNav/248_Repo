use publications;

#CHALLENGE 1
#STEP 1
select s.title_id as 'title', ta.au_id as 'author_id', t.advance * ta.royaltyper / 100 as 'advance',
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as 'sales_royalty'
from sales s
inner join titles t on s.title_id = t.title_id
inner join titleauthor ta on s.title_id = ta.title_id;

#STEP 2
select title_id, author_id, sum(advance) as 'aggregated_advance', 
sum(sales_royalty) as 'aggregated_royalties'
from (select s.title_id, ta.au_id as 'author_id', t.advance * ta.royaltyper / 100 as 'advance',
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as 'sales_royalty'
from sales s
inner join titles t on s.title_id = t.title_id
inner join titleauthor ta on s.title_id = ta.title_id) as step1
group by title_id, author_id;

#STEP 3
select author_id, aggregated_advance + aggregated_royalties as 'profits'
from (select title_id, author_id, sum(advance) as 'aggregated_advance', 
sum(sales_royalty) as 'aggregated_royalties'
from (select s.title_id, ta.au_id as 'author_id', t.advance * ta.royaltyper / 100 as 'advance',
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as 'sales_royalty'
from sales s
inner join titles t on s.title_id = t.title_id
inner join titleauthor ta on s.title_id = ta.title_id) as step1
group by title_id, author_id) as step2
group by title_id
order by profits desc
limit 3;

#CHALLENGE 2
create temporary table publications.challenge2
select s.title_id, ta.au_id as 'author_id', sum(t.advance * ta.royaltyper / 100) +
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'profits'
from sales s
inner join titles t on s.title_id = t.title_id
inner join titleauthor ta on s.title_id = ta.title_id
group by title_id, author_id
order by profits desc
limit 3;

#CHALLENGE 3
create table most_profiting_authors
select author_id as 'Author ID', profits as 'Proftis' from challenge2;
select * from most_profiting_authors;