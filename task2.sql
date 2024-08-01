SELECT s.survey_name, q.question_text, r.response_text
FROM  responses r JOIN 
	  questions q ON r.question_id = q.question_id JOIN
      surveys s ON q.survey_id = s.survey_id
WHERE s.survey_id = 3;
############
SELECT s.survey_name, q.question_text, r.response_text
FROM  surveys s JOIN 
      questions q ON s.survey_id = q.survey_id JOIN
      responses r ON q.question_id = r.question_id
WHERE  s.survey_id = 3;



SELECT s.survey_name, AVG(
							CASE
								WHEN r.response_text = 'Very satisfied' THEN 5
								WHEN r.response_text = 'Satisfied' THEN 4
								WHEN r.response_text = 'Neutral' THEN 3
								WHEN r.response_text = 'Dissatisfied' THEN 2
								WHEN r.response_text = 'Very dissatisfied' THEN 1
								ELSE NULL
							END
						) AS average_score
FROM surveys s JOIN
     questions q ON s.survey_id = q.survey_id JOIN
     responses r ON q.question_id = r.question_id
GROUP BY s.survey_name;
##############
ALTER TABLE responses
ADD COLUMN response_score INT;
set sql_safe_updates=0;
UPDATE responses
SET response_score = CASE response_text
                WHEN 'Very satisfied' THEN 5
                WHEN 'Satisfied' THEN 4
                WHEN 'Neutral' THEN 3
                WHEN 'Dissatisfied' THEN 2
                WHEN 'Very dissatisfied' THEN 1
            END;
##############
SELECT s.survey_name, AVG(r.response_score) AS average_score
FROM responses r JOIN 
	 questions q ON r.question_id = q.question_id JOIN 
     surveys s ON q.survey_id = s.survey_id
GROUP BY s.survey_name
ORDER BY average_score DESC;


SELECT u.user_name, AVG(
						   CASE r.response_text
							   WHEN 'Very satisfied' THEN 5
							   WHEN 'Satisfied' THEN 4
							   WHEN 'Neutral' THEN 3
							   WHEN 'Dissatisfied' THEN 2
							   WHEN 'Very dissatisfied' THEN 1
						   END
					   ) AS average_score
FROM responses r JOIN 
	users u ON r.user_id = u.user_id
GROUP BY u.user_name
ORDER BY average_score DESC
LIMIT 3;
##################
SELECT u.user_name, AVG(r.response_score) AS average_score
FROM responses r JOIN
	 users u ON r.user_id = u.user_id
GROUP BY u.user_name
ORDER BY average_score DESC
LIMIT 3;


SELECT q.question_id, q.question_text, r.response_text, COUNT(*) AS response_count
FROM questions q JOIN 
	 responses r ON q.question_id = r.question_id
WHERE q.survey_id = 2
GROUP BY q.question_id, q.question_text, r.response_text
ORDER BY q.question_id, r.response_text;

