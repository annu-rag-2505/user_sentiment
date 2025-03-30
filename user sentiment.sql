create database  if not exists usersentiment;

create table if not exists sentiment(
   name varchar(30) not null ,
   username varchar(20) not null primary key,
   platform varchar(10) not null,
   date DATETIME not null,
   AI_Tool_Mention VARCHAR(10) NOT NULL,
   rating float(4,2) not null,
   comment varchar(100) not null
   );

alter table sentiment modify rating float(4,2);
--------- adding a coloumn--------------------------------------------------------------------
alter table sentiment add column impression varchar(10);

update sentiment set impression =(
 case
  when rating between 0 and 1 then 'bad'
  when rating between 1 and 2 then 'negative'
  when rating between 2 and 3 then 'neutral'
  when rating between 3 and 4 then 'positive'
  else
   'best'
   end
   );
   
------------------------------------------ Overall impression Distribution--------------------------------------------------------------------
   
   select impression, count(*) as total 
   from sentiment 
   group by impression
   order by total desc;
   
   ------------------------------------ Platform-Based impression Analysis---------------------------------------------------------------------
   
   select platform,impression, count(*) as total 
   from sentiment 
   group by platform,impression
   order by platform,CASE 
             WHEN impression LIKE '%Best%' THEN 1 
             WHEN impression LIKE '%Positive%' THEN 2 
             WHEN impression LIKE '%Neutral%' THEN 3 
             WHEN impression LIKE '%Negative%' THEN 4 
             WHEN impression LIKE '%Bad%' THEN 5 
             ELSE 6 
         END
   ;
         
  ----------------------- AI Tool Comparison Based on Ratings--------------------------------
  
  select AI_Tool_Mention, avg(rating) as average
   from sentiment 
   group by AI_Tool_Mention
   order by average desc;
   
   ------------------------------ Time-Based impression Trend-----------------------------------------
   select date,platform
   ,impression,count(*) as count
   from sentiment 
   group by date,platform,impression
   order by platform desc;
   
   ---------------------------- Most Active Users (Frequent Commenters)-----------------------------------------
SELECT Coalesce(Username,'total') AS Username, 
       COUNT(*) AS Comment_Count 
FROM sentiment
GROUP BY Username with rollup
ORDER BY Comment_Count DESC
;   

--------------------------- Platform Preference for AI Tools---------------------------------------------
select platform,AI_Tool_Mention ,count(*)as total
   from sentiment 
   group by platform,AI_Tool_Mention
   order by platform desc;
   
   --------------------------------- Sentiment Score Analysis---------------------------------------------
   
   select impression, round(avg(rating), 2) as average
   from sentiment 
   group by impression
   order by average desc;
   
   -------------------------------------------- Peak Engagement Period Analysis-------------------------------------------------
   select distinct Coalesce(date,'total row'), count(*) as max_comment
   from sentiment 
   group by date with rollup
   order by max_comment desc
   ;
   
   ----------------------- Most Loved & Most Hated AI Tool---------------------------------------------------
   
select AI_Tool_Mention,
 sum(case when impression like '%POSTIVE%' OR IMPRESSION LIKE  '%BEST%' THEN 1 ELSE 0 END) AS LOVED_TOOL,
 sum(case when impression like '%NEGATIVE%' OR IMPRESSION LIKE  '%BAD%' THEN 1 ELSE 0 END) AS HATED_TOOL
   from sentiment 
   group by AI_TOOL_MENTION
   order by LOVED_TOOL desc,HATED_TOOL desc; 
 
 ----------------------------------- User Loyalty Analysis-----------------------------------------------------------------------
   SELECT Username, COUNT( Date) AS Active_Days
FROM sentiment
GROUP BY Username
HAVING Active_Days > 1
ORDER BY Active_Days DESC;

------------------------------------- Sentiment Shifts Over Time-------------------------------------------------------------
   select distinct AI_Tool_Mention,date,
 sum(case when impression like '%POSTIVE%' OR IMPRESSION LIKE  '%BEST%' THEN 1 ELSE 0 END) AS LOVED_TOOL,
 sum(case when impression like '%NEGATIVE%' OR IMPRESSION LIKE  '%BAD%' THEN 1 ELSE 0 END) AS HATED_TOOL
   from sentiment 
   group by date,AI_TOOL_MENTION
   order by LOVED_TOOL desc,HATED_TOOL DESC; 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   