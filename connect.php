<?php
function OpenCon()
{
$dbhost = "localhost:80";
$dbuser = "root";
     $dbpass = "";
     $db = "videogame-sql";
     $conn = new mysqli($dbhost, $dbuser,
     $dbpass,$db) or die("Connect failed: %s\n".
     $conn -> error);
     return $conn;
}
function CloseCon($conn)
{
$conn -> close(); }
?>