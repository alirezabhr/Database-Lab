-- Create index for first name
create index userfn on test_user(first_name);
create index userln on test_user(last_name);
drop index userfn, userln;

create index userfullname on test_user(first_name, last_name);
drop index userfullname;


create index user_first_name_md5 on test_user(md5(first_name));
drop index user_first_name_md5;


select count(*) from test_user
where (test_user.first_name ilike '%F%' or test_user.last_name ilike '%p%')
and not (test_user.first_name ilike '%F%' and test_user.last_name ilike '%p%');

-- Show query plan for queries with 'explain'
explain select count(*) from test_user
where (test_user.first_name ilike '%F%' or test_user.last_name ilike '%p%')
and not (test_user.first_name ilike '%F%' and test_user.last_name ilike '%p%');

explain select last_name from test_user
where first_name ilike 'B%';

