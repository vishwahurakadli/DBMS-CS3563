CREATE OR REPLACE TEMP VIEW  author_list_view(id, list) AS
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
SELECT p3.id paper_id,
	p3.title paper_title,
	a3.list author_list,
	cf3.venue paper_venue,
	p1.id citing_paper_second_lev,
	p1.title cp_title,
	a1.list cp_author_list,
	cf1.venue cp_venue
FROM research_paper p1,
	research_paper p2,
	research_paper p3,
	cited_by c1,
	cited_by c2,
	author_list_view a1,
	author_list_view a3,
	conference cf1,
	conference cf3
WHERE p1.id = c1.id
	AND p2.id = c1.cited_by
	AND p2.id = c2.id
	AND p3.id = c2.cited_by
	AND a1.id = p1.id
	AND a3.id = p3.id
	AND cf1.id = p1.id
	AND cf3.id = p3.id
ORDER BY p3.id;