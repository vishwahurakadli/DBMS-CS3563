SELECT Coauthor_1.first_name || ' ' || Coauthor_1.middle_name || ' ' || Coauthor_1.last_name AS Coauthor_1,
   T2.first_name || ' ' || T2.middle_name || ' ' || T2.last_name AS Coauthor_2,
   Coauthor_1.joint_paper_count AS Paper_count
FROM (
      (
         SELECT T1.author_id AS Coauthor_id1,
            T2.author_id AS Coauthor_id2,
            COUNT(*) AS joint_paper_count
         FROM written_by AS T1
            LEFT JOIN written_by AS T2 ON T1.paper_id = T2.paper_id
            AND T1.author_id != T2.author_id
         GROUP BY T1.author_id,
            T2.author_id
      ) AS num_paper
      LEFT JOIN author AS T1 ON num_paper.Coauthor_id1 = T1.id
   ) AS Coauthor_1
   LEFT JOIN author AS T2 ON Coauthor_1.Coauthor_id2 = T2.id
WHERE Coauthor_1.joint_paper_count > 1
   AND Coauthor_1.Coauthor_id2 IS NOT NULL;