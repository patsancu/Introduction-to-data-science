select SUM(a.value * b.value), a.row_num, b.col_num from a,b where b.row_num = a.col_num GROUP BY a.row_num, b.col_num;
insert into mult select row_num, col_num, value from( select SUM(a.value * b.value) as value, a.row_num , b.col_num from a,b where b.row_num = a.col_num GROUP BY a.row_num, b.col_num);
#2874