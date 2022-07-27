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
  $nameIn = $_POST['nameIn'];
  $nameAns = $_POST['nameAns'];
  $fieldIn = $_POST['fieldIn'];
  $fieldInOther = $_POST['fieldInOther'];
  $fieldAns = $_POST['fieldAns'];
  $constraintField = $_POST['constraintField'];
  $constraintValue = $_POST['constraintValue'];
  $condition = $_POST['condition'];

  if ($constraintValue == "") {
    $sql = "SELECT $fieldAns 
      FROM $nameIn, $nameAns 
      WHERE $nameIn.$fieldIn=$nameAns.$fieldInOther";
  } else if ($condition == "greater") {
    $sql = "SELECT $fieldAns
      FROM $nameIn, $nameAns
      WHERE $nameIn.$fieldIn=$nameAns.$fieldInOther
      AND $constraintField > $constraintValue";
  } else if ($condition == "less") {
    $sql = "SELECT $fieldAns
      FROM $nameIn, $nameAns
      WHERE $nameIn.$fieldIn=$nameAns.$fieldInOther
      AND $constraintField < $constraintValue";
  } else { // $condition == "equal"
    $sql = "SELECT $fieldAns
      FROM $nameIn, $nameAns
      WHERE $nameIn.$fieldIn=$nameAns.$fieldInOther
      AND $constraintField = '$constraintValue'";
  }

  myTable($conn, $sql);
  
?>