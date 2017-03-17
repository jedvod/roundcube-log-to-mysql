#DROP TABLE IF EXISTS smtp_logs;
CREATE TABLE  IF NOT EXISTS smtp_logs (
         id int(11) NOT NULL auto_increment,
	 queue varchar(12) NOT NULL,
	 date date NOT NULL,
	 time time NOT NULL,
	 email_from varchar(200) NOT NULL,
	 email_to varchar(200) NOT NULL,
	 size int(20) default NULL,
	 status varchar(20) default NULL,
	 status_comment varchar(200) default NULL,
         PRIMARY KEY  (id),
	 INDEX (date),
	 INDEX (email_from, email_to))  ENGINE=InnoDB;
DROP TABLE IF EXISTS noqueue_logs;
CREATE TABLE IF NOT EXISTS noqueue_logs (
	 id int(11) NOT NULL auto_increment,
	 date date NOT NULL,
	 time time NOT NULL,
	 email_from varchar(200) NOT NULL,
	 email_to varchar(200) NOT NULL,
	 error_msg varchar(200) NOT NULL,
	 PRIMARY KEY (id),
	 INDEX (date),
	 INDEX (email_from, email_to)) ENGINE=InnoDB;
