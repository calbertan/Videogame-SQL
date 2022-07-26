<?php
  include '../connect.php';
  $conn = OpenCon();

  if (isset($_POST['platform'])) {
    $name = $_POST['name'];
    $year = $_POST['year'];

    if ($year == "") {
      $year = "NULL";
    } else {
      $year = strval($year);
    }
    $company = $_POST['company'];
  
  
    if ($year == "NULL") {
      $sql = "INSERT INTO Platform VALUES('$name', NULL, '$company');";
    } else {
      $sql = "INSERT INTO Platform VALUES('$name', '$year', '$company');";
    }
  
    if ($conn->query($sql)) {
      echo "Query entered was: $sql";
      echo "Insert command executed successfully";
    } else {
      echo "Error inserting into table: " . $conn->error;
    }
  } else if (isset($_POST['ip'])) {
    $name = $_POST['name'];
    $sql = "INSERT INTO ip VALUES('$name');";
    if ($conn->query($sql)) {
      echo "Query entered was: $sql";
      echo "Insert command executed successfully";
    } else {
      echo "Error inserting into table: " . $conn->error;
    }
  } else if (isset($_POST['consumer'])) {
    $name = $_POST['name'];
    if ($name == "") {
      $name = "NULL";
    }
    $id = $_POST['id'];

    $age = $_POST['age'];
    if ($age == "") {
      $age = "NULL";
    } else {
      $age = strval($age);
    }
  
    if ($name == "NULL" && $age == "NULL") {
      $sql = "INSERT INTO Consumer VALUES(NULL, '$id', NULL);";
    } else if ($name == "NULL") {
      $sql = "INSERT INTO Consumer VALUES(NULL, '$id', '$age');";
    } else if ($age == "NULL") {
      $sql = "INSERT INTO Consumer VALUES('$name', '$id', NULL);";
    } else {
      $sql = "INSERT INTO Consumer VALUES('$name', '$id', '$age');";
    }
  
    if ($conn->query($sql)) {
      echo "Query entered was: $sql";
      echo "Insert command executed successfully";
    } else {
      echo "Error inserting into table: " . $conn->error;
    }
  }

  
?>