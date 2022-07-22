<?php
include 'connect.php';
$conn = OpenCon();
myTable($conn,$sql);
$sql = $_POST['query'];
if ($conn->query($sql)) {
    echo "Query entered was: $sql";
    echo "Table MyGuests created successfully";
  } else {
    echo "Table MyGuests created successfully";
    echo "Error creating table: " . $conn->error;
  }
  
?>