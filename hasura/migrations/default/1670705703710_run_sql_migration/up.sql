CREATE OR REPLACE VIEW user_article_access AS
select u.id as user_id, a.id as article_id
from "user" u 
cross join article a;
