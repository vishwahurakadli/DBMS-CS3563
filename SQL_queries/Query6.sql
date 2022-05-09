SELECT au1.first_name || ' ' || au1.middle_name || ' ' || au1.last_name Author1,
    au2.first_name || ' ' || au2.middle_name || ' ' || au2.last_name Author2,
    au3.first_name || ' ' || au3.middle_name || ' ' || au3.last_name Author3,
    count(*) count
FROM author au1,
    author au2,
    author au3,
    (
        SELECT table_2.paper1_a a1,
            table_2.paper2_a a2,
            written_by.author_id AS a3
        FROM (
                SELECT table_1.paper1_id,
                    table_1.paper1_a,
                    table_1.paper2_id,
                    table_1.paper2_a,
                    cited_by.cited_by AS paper3_id
                FROM (
                        SELECT cited_by.id as paper1_id,
                            T1.author_id AS paper1_a,
                            cited_by.cited_by AS paper2_id,
                            T2.author_id AS paper2_a
                        FROM cited_by
                            LEFT JOIN written_by AS T1 ON cited_by.id = T1.paper_id
                            AND T1.co_author = 1
                            LEFT JOIN written_by AS T2 ON cited_by.cited_by = T2.paper_id
                        WHERE T1.paper_id != T2.paper_id
                    ) AS table_1
                    LEFT JOIN cited_by ON table_1.paper2_id = cited_by.id
                WHERE cited_by.cited_by IS NOT NULL
            ) AS table_2
            LEFT JOIN written_by ON table_2.paper3_id = written_by.paper_id
        ORDER BY table_2.paper1_id
    ) trng
WHERE au1.id = trng.a1
    AND au2.id = trng.a2
    AND au3.id = trng.a3
GROUP BY au1.id,
    au2.id,
    au3.id;