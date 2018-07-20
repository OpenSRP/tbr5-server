INSERT INTO `openmrs`.`encounter_type` (`name`, `description`, `creator`, `date_created`, `retired`, `uuid`) 
VALUES 
('Intreatment TB patient', 'Intreatment TB patient', '2', NOW(), '0', UUID()),
('Positive TB patient', 'Positive TB patient', '2', NOW(), '0', UUID()),
('Screening', 'Screening', '2', NOW(), '0', UUID()),
('Add TB Contact', 'Add TB Contact', '2', NOW(), '0', UUID()),
('Contact Screening', 'Contact Screening', '2', NOW(), '0', UUID()),
('TB Diagnosis', 'TB Diagnosis', '2', NOW(), '0', UUID()),
('Follow up Visit', 'Follow up Visit', '2', NOW(), '0', UUID()),
('Remove Patient', 'Remove Patient', '2', NOW(), '0', UUID()),
('X-Ray Result', 'X-Ray Result', '2', NOW(), '0', UUID()),
('Culture Result', 'Culture Result', '2', NOW(), '0', UUID()),
('GeneXpert Result', 'GeneXpert Result', '2', NOW(), '0', UUID()),
('Smear Result', 'Smear Result', '2', NOW(), '0', UUID()),
('Treatment Initiation', 'Treatment Initiation', '2', NOW(), '0', UUID()),
('Treatment Outcome', 'Treatment Outcome', '2', NOW(), '0', UUID());

INSERT INTO `openmrs`.`person_attribute_type` (`name`, `description`, `format`, `creator`, `date_created`, `retired`, `sort_weight`, `uuid`) 
VALUES 
('Primary Contact Number', 'Primary Contact Number', 'java.lang.String', '2', NOW(), '0', '0', UUID()),
('CNIC', 'CNIC', 'java.lang.String', '2', NOW(), '0', '0', UUID());

INSERT INTO `openmrs`.`role` (`role`, `description`, `uuid`) 
VALUES 
('opensrp-rest-service', 'Default role for OpenSRP REST Service', UUID());

INSERT INTO `openmrs`.`users` (`user_id`, `system_id`, `username`, `password`, `salt`, `secret_question`, `secret_answer`, `creator`, `date_created`, `changed_by`, `date_changed`, `person_id`, `retired`, `retired_by`, `date_retired`, `retire_reason`, `uuid`)
VALUES 
(5, '5-6', 'restangelservice', 'b17ea68ee2c9dd6099af4d5b3b530b2ef2f08acff0471242c887ceed3e2eb0ccaa37f8a505f6856593a42b8618a930cf55001dd5fb8e911dfb179c06af3c4c67', 'b7494ef1b40e54b21c22ebb38bc8fb1f6795a72a56c98c1ebbc928a3691e86e034d701bfa53cd693260c25c5ee6b9f5d568a3d9bee9ab7d79e5f1067a8fe07ed', '', NULL, 1, '2016-03-29 12:24:49', 1, '2016-03-29 12:24:49', 2, 0, NULL, NULL, NULL, UUID());

INSERT INTO `openmrs`.`user_role` (`user_id`, `role`)
VALUES
(5, 'opensrp-rest-service'),
(5, 'System Developer');
