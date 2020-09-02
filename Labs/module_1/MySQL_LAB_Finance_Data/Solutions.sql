use finance;

#CHALLENGE 1
select district_id,  count(distinct account_id) as ac_freq
from account
group by district_id
order by district_id asc
limit 5;

#CHALLENGE 2
select account_id, group_concat(distinct bank_to) as bank_to,
count(distinct amount) as diff, group_concat(amount) as rent
from finance.order
where k_symbol='SIPO'
group by account_id
having diff;

#CHALLENGE 3
select a.account_id, max(amount) as max_amount, district_id
from(
select account_id, amount
from finance.order o
where k_symbol='UVER') ml
inner join account a on ml.account_id=a.account_ID
group by district_id
order by 2 desc;

#CHALLENGE 4
select a.account_id, sum(amount) as 'sum_amount', district_id
from(
select account_id, amount
from finance.order o
where k_symbol='UVER') ml
inner join account a on ml.account_id=a.account_ID
group by district_id
order by 2 desc;

#CHALENGE 5
#mean
select district_id, avg(amount) as 'mean_amount' from(
select account_id, amount
from finance.order o
where k_symbol='UVER') ml
inner join account a
on ml.account_id = a.account_id
group by district_id
order by 2 desc;

#median
create table xxx
select l.account_id, district_id, amount
from account a
inner join loan l on a.account_id=l.account_id;

  #option 1
select xxx.amount, @rownum:=@rownum+1 as 'row_number', @total_rows:=@rownum
from xxx, (select @rownum:=0) r
where xxx.amount is not null
order by xxx.amount;

  #option 2
select * from (
Select x.district_id, x.amount, count(y.amount) as ranking
from xxx x, xxx y
where x.district_id=y.district_id and x.amount<y.amount
group by district_id, x.amount) as ranked_table
where exists (
  select xl.district_id, ceil(count(xl.amount)/2) ranking
  from xxx xl
  group by district_id
  having ranked_table.district_id = xl.district_id and ranked_table.ranking=ranking);