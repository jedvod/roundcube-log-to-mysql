CREATE OR REPLACE VIEW MainView AS
	SELECT DATE(DeviceReportedTime) as date,TIME(DeviceReportedTime) as time,Message as message
	FROM SystemEvents;

/*SELECT * FROM MainView;*/
