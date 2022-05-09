CREATE OR REPLACE TEMP VIEW author_list_view(id, list) AS
SELECT wb.paper_id id,
    STRING_AGG(
        au.first_name || ' ' || au.middle_name || ' ' || au.last_name,
        ' , '
        ORDER BY wb.co_author
    ) author_list
FROM author au,
    written_by wb
WHERE au.id = wb.author_id
GROUP BY wb.paper_id;
-- 
-- 
-- 
-- 
SELECT p2.id paper_id,
    p2.title paper_title,
    a2.list author_list,
    cf2.venue venue,
    p1.id citing_paper,
    p1.title c_title,
    a1.list author_list,
    cf1.venue c_venue
FROM research_paper p1,
    research_paper p2,
    cited_by c,
    conference cf1,
    conference cf2,
    author_list_view a1,
    author_list_view a2
WHERE p1.id = c.id
    AND p2.id = c.cited_by
    AND a1.id = p1.id
    AND a2.id = p2.id
    AND cf1.id = p1.id
    AND cf2.id = p2.id
order by p2.id;