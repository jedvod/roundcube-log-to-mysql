DROP FUNCTION IF EXISTS getqueue;
DELIMITER $$
CREATE FUNCTION getqueue (Message text) RETURNS VARCHAR(12)
BEGIN
RETURN SUBSTR(Message,2,12);
END$$
DELIMITER ;

#DROP INDEX msg ON SystemEvents;
#CREATE FULLTEXT INDEX msg ON SystemEvents (Message);


CREATE OR REPLACE VIEW EmailtoStatus AS
	SELECT DISTINCT	getqueue(Message) as queue,
	SUBSTR(ReceivedAt,1,10) as date,
	SUBSTR(ReceivedAt,12,8) as time,
	SUBSTR(Message,LOCATE(': to=',Message)+6,LOCATE('>',Message)-LOCATE(': to=',Message)-6) as email_to,
	SUBSTR(Message,LOCATE('status=',Message)+7,LOCATE('(',Message)-LOCATE('status=',Message)-7) as status,
	SUBSTR(Message,LOCATE('(',Message)+1,LOCATE(')',Message)-LOCATE('(',Message)-1) as status_comment
	FROM SystemEvents WHERE getqueue(Message) REGEXP '^[A-Z0-9]*$' AND LOCATE(': to=', Message) > 0 AND LOCATE ('message-id=<>',Message) = 0;

#SELECT * FROM EmailtoStatus LIMIT 35;

CREATE OR REPLACE VIEW EmailfromSize AS
	SELECT DISTINCT getqueue(Message) as queue,
	SUBSTR(ReceivedAt,1,10) as date,#
	SUBSTR(ReceivedAt,12,8) as time,#
	SUBSTR(Message,LOCATE(': from=',Message)+8,LOCATE('>',Message)-LOCATE(': from=',Message)-8) as email_from,
	SUBSTR(Message,LOCATE('size=',Message)+5,LOCATE('nrcpt=',Message)-LOCATE('size=',Message)-7) as size
	FROM SystemEvents WHERE getqueue(Message) REGEXP '^[A-Z0-9]*$' AND LOCATE(': from=',Message) > 0 AND LOCATE ('message-id=<>',Message) = 0;

#SELECT * FROM EmailfromSize LIMIT 25;

CREATE OR REPLACE VIEW NoQueue AS
	SELECT SUBSTR(ReceivedAt,1,10) as date,
	SUBSTR(ReceivedAt,12,8) as time,
	SUBSTR(Message,LOCATE('from=<',Message)+6,LOCATE('> to=<',Message)-LOCATE('from=<',Message)-6) as email_from,
	SUBSTR(Message,LOCATE('> to=<',Message)+6,LOCATE('> proto=',Message)-LOCATE('> to=<',Message)-6) as email_to,
	SUBSTR(Message,LOCATE(']: ',Message)+3,LOCATE('; from=<',Message)-LOCATE(']: ',Message)-3) as ErrorMsg
	FROM SystemEvents WHERE SUBSTR(Message,2,16) LIKE 'NOQUEUE: reject:' AND LOCATE('from=<',Message) >0 AND LOCATE ('to=<',Message) >0;

SELECT * FROM NoQueue;

CREATE OR REPLACE VIEW MainView AS
	SELECT queue,date,time,
	(SELECT DISTINCT email_from FROM EmailfromSize WHERE EmailfromSize.queue = EmailtoStatus.queue LIMIT 1) as email_from,
	email_to,
	(SELECT DISTINCT size FROM EmailfromSize WHERE EmailfromSize.queue = EmailtoStatus.queue LIMIT 1) as size,
	status,status_comment
	FROM EmailtoStatus;

#SELECT * FROM MainView;

