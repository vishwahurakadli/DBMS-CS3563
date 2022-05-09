SELECT p1.id id,
	p1.title Title,
	p2.id Cited_paper_id,
	p2.title cp_Title,
	al.author_list cp_authors,
	cf.venue cp_venue
FROM research_paper p1,
	research_paper p2,
	cited_by cb,
	conference cf,
	(
		SELECT wb.paper_id id,
			STRING_AGG(
				au.first_name || ' ' || au.middle_name || ' ' || au.last_name,
				' , '
				ORDER BY wb.co_author
			) author_list
		FROM author au,
			written_by wb
		WHERE au.id = wb.author_id
		GROUP BY wb.paper_id
	) AS al
WHERE p1.id = cb.id
	AND p2.id = cb.cited_by
	AND al.id = p2.id
	AND cf.id = p2.conference_id;