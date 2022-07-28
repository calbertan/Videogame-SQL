<?php
  function myTable($obConn,$sql) {
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
        echo "<td><strong>Console</strong></td>";
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
  
  $sql = "SELECT * FROM available_on WHERE NOT EXISTS
  (SELECT name FROM platform WHERE discontinued IS NOT NULL AND available_on.platform_name = platform.name)";

  if ($conn->query($sql)) {
    echo "Displaying all videogames on NON DISCONTINUED platforms" . "<br>";
  } else {
    echo "Error deleting entry: " . $conn->error;
  }

  myTable($conn, $sql);
  
  
?>