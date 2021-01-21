#DROP TABLE IF EXISTS roundcube_logs;
CREATE TABLE  IF NOT EXISTS roundcube_logs (
	id int(11) NOT NULL auto_increment,
	date varchar(10) NOT NULL,
	time varchar(8) NOT NULL,
	log text
	PRIMARY KEY (ID))  ENGINE=InnoDB;
