select count(*) from Frequency where docid = '10398_txt_earn';
# 138
select count(term) from Frequency where docid = '10398_txt_earn' and count = 1;
# 110
select count(term) from (select term from Frequency where docid = '10398_txt_earn' and count = 1 UNION select term from Frequency where docid = '925_txt_trade' and count = 1);
#324
select count(*) from Frequency where term='parliament';
#15
select count(*) from (select docid,SUM(count) from Frequency GROUP BY docid HAVING (SUM(count) > 300) );
#107
select * from Frequency f1, Frequency f2 where f1.term = 'transactions' and f2.term = 'world' and f1.docid = f2.docid;
OR
select count(*) FROM Frequency f1 JOIN Frequency f2 on f1.term = 'transactions' and f2.term = 'world' and f1.docid = f2.docid;
#3