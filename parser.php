<?php

$link=mysqli_connect("localhost", "root", "1234567", "postfix");
if (mysqli_connect_errno()) {
	printf("Connect failed: %s\n", mysqli_connect_error());
	exit();
}
mysqli_query($link, 'set names utf8');


$result=mysqli_query($link,"SELECT * FROM MainView WHERE date NOT LIKE SUBSTR(NOW(),1,10) ORDER BY CONCAT (date,time) ASC");
while($data = mysqli_fetch_array($result)) 
{
$queue=$data['queue'];
$date=$data['date'];
$time=$data['time'];
$email_from=$data['email_from'];
$email_to=$data['email_to'];
$size=$data['size'];
$status=$data['status'];
$status_comment=$data['status_comment'];
mysqli_query($link,"INSERT INTO smtp_logs (queue, date, time, email_from, email_to, size, status, status_comment) VALUES ('$queue', '$date', '$time', '$email_from', '$email_to', '$size', '$status', '$status_comment')");
}

$result=mysqli_query($link,"SELECT * FROM NoQueue WHERE date NOT LIKE SUBSTR(NOW(),1,10) ORDER BY CONCAT (date,time) ASC");
while($data = mysqli_fetch_array($result)) 
{
$date=$data['date'];
$time=$data['time'];
$email_from=$data['email_from'];
$email_to=$data['email_to'];
$error_msg=$data['ErrorMsg'];
mysqli_query($link,"INSERT INTO noqueue_logs (date, time, email_from, email_to, error_msg) VALUES ('$date', '$time', '$email_from', '$email_to', '$error_msg')");
}

mysqli_free_result($result);
mysqli_query($link,"DELETE FROM SystemEvents WHERE SUBSTR(ReceivedAt,1,10) NOT LIKE SUBSTR(NOW(),1,10)");
mysqli_query($link,"OPTIMIZE TABLE SystemEvents");
mysqli_close($link);
?>
