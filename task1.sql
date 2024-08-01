#CREATE DATABASE DBsurveys;

use DBsurveys;

CREATE TABLE surveys (
    survey_id int AUTO_INCREMENT,
    survey_name varchar(255),
    created_at date,
    PRIMARY KEY (survey_id)
);
CREATE TABLE questions (
    question_id int AUTO_INCREMENT,
    survey_id int,
    question_text varchar(255),
    PRIMARY KEY (question_id),
    FOREIGN KEY (survey_id) REFERENCES surveys(survey_id)
);
CREATE TABLE users (
    user_id int AUTO_INCREMENT,
    user_name varchar(255),
    user_email varchar(255),
    PRIMARY KEY (user_id),
	UNIQUE KEY (user_email)
);
CREATE TABLE responses (
    response_id int AUTO_INCREMENT,
    user_id int,
    question_id int,
    response_text varchar(255),
    PRIMARY KEY (response_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

use DBsurveys;

#INSERTS 

INSERT INTO surveys (survey_name, created_at) VALUES
('Parents Satisfaction with the School', '2024-01-15'),
('Students’ Opinions on the Curriculum', '2024-02-10'),
('Evaluation of the School Environment', '2024-03-05');

INSERT INTO questions (survey_id, question_text) VALUES
(1, 'How satisfied are you with the quality of education your child receives?'),
(1, 'How would you rate the effectiveness of the school’s communication with parents?'),
(2, 'How engaging do you find the current curriculum?'),
(2, 'How well do you think the curriculum prepares you for future studies?'),
(3, 'How satisfied are you with the cleanliness of the school facilities?'),
(3, 'How safe do you feel in the school environment?');
INSERT INTO users (user_name, user_email) VALUES
('John Smith', 'john.smith@example.com'),
('Mary Johnson', 'mary.johnson@example.com'),
('Charles Williams', 'charles.williams@example.com'),
('Anna Brown', 'anna.brown@example.com'),
('Louis Davis', 'louis.davis@example.com');
INSERT INTO responses (user_id, question_id, response_text) VALUES
(1, 1, 'Neutral'),
(1, 2, 'Very satisfied'),
(2, 1, 'Satisfied'),
(2, 2, 'Neutral'),
(3, 1, 'Very dissatisfied'),
(3, 2, 'Satisfied'),
(4, 1, 'Dissatisfied'),
(4, 2, 'Dissatisfied'),
(5, 1, 'Very satisfied'),
(5, 2, 'Satisfied'),
(1, 3, 'Satisfied'),
(1, 4, 'Satisfied'),
(2, 3, 'Very satisfied'),
(2, 4, 'Very dissatisfied'),
(3, 3, 'Neutral'),
(3, 4, 'Very satisfied'),
(4, 3, 'Satisfied'),
(4, 4, 'Neutral'),
(5, 3, 'Dissatisfied'),
(5, 4, 'Neutral'),
(1, 5, 'Very dissatisfied'),
(1, 6, 'Satisfied'),
(2, 5, 'Neutral'),
(2, 6, 'Dissatisfied'),
(3, 5, 'Dissatisfied'),
(3, 6, 'Very satisfied'),
(4, 5, 'Very satisfied'),
(4, 6, 'Neutral'),
(5, 5, 'Very satisfied'),
(5, 6, 'Dissatisfied');

#INDEXES

CREATE INDEX idx_survey_id ON questions(survey_id);
CREATE INDEX idx_user_id ON responses(user_id);
CREATE INDEX idx_question_id ON responses(question_id);
CREATE INDEX idx_user_question ON responses(user_id, question_id);









