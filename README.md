# postfix-log-to-mysql
Postfix Logs parser to MySQL

Get nice postfix logs in MySQL database realtime.

MainView (View) - today's mail logs that contains:
Postfix Queue ID, Date, Time, Email From, Email To, Size, Status, Comment
smtp_logs (Table) - archived mail logs.
NoQueue (View) - today's error logs:
Date, Time, Email From, Email To, Error Message.
noqueue_logs (Table) - archived error logs.

Before using this script:
1) use rsyslogd
2) configure postfix log to MySQL database (usually, SystemEvents table)
3) import base.sql to MySQL
4) import view.sql to MySQL
5) edit parser.php mysql connect username and password

./run-parser.sh should be run by cron daily.
