SELECT research_paper.id AS paper_id,
    research_paper.title AS research_paper,
    most_cited.num_papers AS paper_count
FROM (
        SELECT cited_by.cited_by AS paper_id,
            COUNT(*) AS NUM_PAPERS
        FROM cited_by
        GROUP BY cited_by.cited_by
        ORDER BY NUM_PAPERS DESC
        FETCH FIRST 20 ROWS ONLY
    ) AS most_cited
    LEFT JOIN research_paper ON research_paper.id = most_cited.paper_id;