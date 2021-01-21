<?php

$link=mysqli_connect("localhost", "roundcube-logs", "password", "roundcube_db");
if (mysqli_connect_errno()) {
        printf("Connect failed: %s\n", mysqli_connect_error());
        exit();
}
mysqli_query($link, 'set names utf8');


$result=mysqli_query($link,"SELECT * FROM MainView WHERE date != CURDATE()");
while($data = mysqli_fetch_array($result))
{
$date=$data['date'];
$time=$data['time'];
$log=$data['message'];
mysqli_query($link,"INSERT INTO roundcube_logs (date, time, log) VALUES ('$date', '$time', '$log')");
}

mysqli_free_result($result);
mysqli_query($link,"DELETE FROM SystemEvents WHERE DATE(DeviceReportedTime) != CURDATE()");
mysqli_query($link,"OPTIMIZE TABLE SystemEvents");
mysqli_close($link);
?>
