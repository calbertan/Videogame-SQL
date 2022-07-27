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

  function create() {
    echo "<h1>This page updates the existing data in the Platform table</h1>";

    echo "<form action=\"updateFull.php\" method=\"post\">";
    echo "</br>Columns in Platform tables are :";
    echo "</br>";
    echo "Name of game platform";
    echo "</br>";
    echo "Year of discontinuation (empty or NULL if not yet discontinued)";
    echo "</br>";
    echo "Name of company that manufactured it";
    echo "</br>";
    echo "</br>";
    echo "<label>Enter the name of the platform entry to be updated</label>";
    echo "<input name=\"name\" type=\"text\" placeholder=\"Type Here\">";
    echo "<br>";
    echo "<label>Update the year of discontinuation</label>";
    echo "<input name=\"year\" type=\"text\" placeholder=\"Type Here\">";
    echo "<br>";
    echo "<br>";
    echo "<input type=\"submit\" value=\"Execute\">";
    echo "</form>";
    echo "<h4>Note: leave the year field blank if platform is no longer discontinued</h4>";
  }


  include '../connect.php';
  $conn = OpenCon();
  $sql = "SELECT * FROM Platform";
  //update code starts here
  $name = $_POST['name'];
  $year = $_POST['year'];
  if ($name == "") {
    echo "Error: platform name field cannot be empty in this query.";
    myTable($conn,$sql);
    create();
  } else {
      if ($year == "") {
        $query = "UPDATE Platform SET discontinued = NULL WHERE Name = '$name'";
      } else {
        $query = "UPDATE Platform SET discontinued = '$year' WHERE Name = '$name'";
      }
      if ($conn->query($query)) {
        echo "Query entered was: $query";
        myTable($conn,$sql);
        create();
      } else {
        echo "Error inserting into table: " . $conn->error;
      }
  }







?>