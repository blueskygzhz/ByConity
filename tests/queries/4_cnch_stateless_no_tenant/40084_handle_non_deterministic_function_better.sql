-- { echo }
select 1 from (select [1, 2] as arr) having count(arrayJoin(arr)) > 1;

select sum(arrayJoin([1, 2])) as sum where arrayJoin([1, 2]) + 1 > 1 having sum > 1;
select arrayJoin([1, 2]) as r, sum(arrayJoin([1, 2])) as s group by r order by r, s;
select ( arrayJoin([1, 2]) + 1 ) + 1 as r, sum(arrayJoin([1, 2])) as s group by arrayJoin([1, 2]) + 1 order by r, s;
select arrayJoin([1, 2]) + 1 as r, sum(arrayJoin([1, 2])) as s order by r, s;
select arrayJoin([1, 2]) as a, rank() over (order by arrayJoin([1, 2])) as b order by a, b;
select arrayJoin([1, 2]) as a, rank() over (order by arrayJoin([1, 2]) + 1) as b order by a, b;
select arrayJoin([1, 2]) as r order by arrayJoin([1, 2]);
select arrayJoin([1, 2]) + 1 as r order by arrayJoin([1, 2]);
select arrayJoin([1, 2]) + 1 in (select 2) order by arrayJoin([1, 2]);
