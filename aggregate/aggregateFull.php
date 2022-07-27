<?php
  function myTable($obConn,$sql) {
    echo "Query entered was: $sql";
    $rsResult = mysqli_query($obConn,$sql) 
      or die(mysqli_error($obConn));
    if(mysqli_num_rows($rsResult)>0) {
      
      echo "<table width=\"100%\" border=\"0\"
        cellspacing=\"2\"
        cellpadding=\"0\"><tr align=\"center\" bgcolor=\"#CCCCCC\">";
      $i = 0;
      while ($i < mysqli_num_fields($rsResult)) {
        $field = mysqli_fetch_field_direct($rsResult, $i);
        $fieldName=$field->name;
        echo "<td><strong>$fieldName</strong></td>";
        $i = $i + 1;
      }
      echo "</tr>";
      
      $bolWhite=true;
      while ($row = mysqli_fetch_assoc($rsResult)) {
        echo $bolWhite ? "<tr bgcolor=\"#CCCCCC\">" :
          "<tr bgcolor=\"#FFF\">";
        $bolWhite=!$bolWhite;
        foreach($row as $data) {
          echo "<td>$data</td>";
        }
        echo "</tr>";
      }
      echo "</table>";
    }
  }


  include '../connect.php';
  $conn = OpenCon();
  $name = $_POST['name'];
  $field = $_POST['field'];
  $method = $_POST['method'];
  if ($method == "count") {
    $sql = "SELECT count($field) FROM $name";
  } else if ($method == "average") {
    $sql = "SELECT avg($field) FROM $name";
  } else if ($method == "sum") {
    $sql = "SELECT sum($field) FROM $name";
  } else if ($method == "min") {
    $sql = "SELECT min($field) FROM $name";
  } else { // $method == max
    $sql = "SELECT max($field) FROM $name";
  }

  myTable($conn, $sql);
  
?>