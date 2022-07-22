<?php
include 'connect.php';
$conn = OpenCon();
$sql = $_POST['query'];
if ($conn->query($sql)) {
    echo "Query entered was: $sql";
    echo "Table created successfully";
  } else {
    echo "Query entered was: $sql";
    echo "Error creating table: " . $conn->error;
  }
  
?>