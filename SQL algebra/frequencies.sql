select f1.docid, f2.docid, SUM(f1.count * f2.count) from Frequency f1, Frequency f2 WHERE f1.term = f2.term GROUP BY f1.docid, f2.docid and f1.docid < f2.docid;
#19
select MAX(addition) from (select f1.docid, f2.docid, SUM(f1.count * f2.count) as addition from newSet f1, newSet f2 WHERE f1.docid='q' and f1.term = f2.term and f1.docid > f2.docid GROUP BY f1.docid, f2.docid );
#6