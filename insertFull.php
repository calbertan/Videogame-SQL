<?php
include 'connect.php';
$conn = OpenCon();
$sql = $_POST['query'];
if ($conn->query($sql)) {
    echo "Query entered was: $sql";
    echo "Insert command executed successfully";
  } else {
    echo "Query entered was: $sql";
    echo "Error inserting into table: " . $conn->error;
  }
  
?>