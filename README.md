# roundcube-log-to-mysql
Roundcube Logs parser to MySQL

Get nice Rouncube logs in MySQL database realtime.

MainView (View) - today's mail logs that contains:
Roundcube logs in format: date, time, log - no more mess within SystemEvents will lots of NULL values.

roundcube_logs (Table) - archived logs.

Before using this script:
1) use rsyslogd
2) configure roundcube log to MySQL database (usually, SystemEvents table) and using a LOCAL* setp in rsyslogd
3) import base.sql to MySQL
4) import view.sql to MySQL
5) edit logs-parser.php mysql connect username and password

./run-parser.sh should be run by cron daily.

setup another script which solely has:
```
#!/bin/bash
cd /directory-of-script-files/
bash ./run-parser.sh
exit 0
```
save the new script within a different directory and then add the following to your cron:
0       1       *       *       *       /bin/bash /script-runner-directory/script-name.sh

This will then move all logs from previous days to the new database at 1 am server time. All logs after that before the next run will be available in MainView
