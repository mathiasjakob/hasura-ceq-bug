CREATE OR REPLACE VIEW user_author_access AS
select u.id as user_id, a.id as author_id
from "user" u 
cross join author a;
