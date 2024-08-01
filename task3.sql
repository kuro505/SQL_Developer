use DBsurveys;

DELIMITER //
CREATE PROCEDURE CalculateSurveyScore(IN surveyId INT)
BEGIN
    DECLARE totalScore INT DEFAULT 0;
    DECLARE responseCount INT DEFAULT 0;
    DECLARE surveyScore DECIMAL(5,2) DEFAULT 0.00;

    SELECT SUM(response_score) AS totalScore, COUNT(*) AS responseCount
    INTO totalScore, responseCount
    FROM responses r JOIN 
		 questions q ON r.question_id = q.question_id
    WHERE q.survey_id = surveyId;

    IF responseCount > 0 THEN
        SET surveyScore = totalScore / responseCount;
    ELSE
        SET surveyScore = 0.00;
    END IF;

    SELECT surveyId AS survey_id, surveyScore AS average_score;
END //
DELIMITER ;

CALL CalculateSurveyScore(1);

DELIMITER //
CREATE PROCEDURE CalculateSurveyweights(IN surveyId INT)
BEGIN
    DECLARE totalScore INT DEFAULT 0;

    SELECT SUM(response_score) AS totalScore
    INTO totalScore
    FROM responses r JOIN 
		 questions q ON r.question_id = q.question_id
    WHERE q.survey_id = surveyId;

    SELECT surveyId AS survey_id, totalScore AS total_score;
END //
DELIMITER ;

CALL CalculateSurveyweights(1);

CREATE VIEW SurveyDetails AS
SELECT s.survey_name, q.question_text, r.response_text, r.response_score
FROM  surveys s JOIN
	  questions q ON s.survey_id = q.survey_id JOIN
      responses r ON q.question_id = r.question_id;
        
 SELECT * FROM SurveyDetails;     
      