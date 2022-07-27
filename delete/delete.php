<?php
  include '../connect.php';
  $conn = OpenCon();

  if (isset($_POST['ip'])) {
    $name = $_POST['name'];

    $sql = "DELETE FROM ip WHERE `ip`.`ip_Name` = '$name'";
    
    if ($conn->query($sql)) {
      echo "IP deleted was: $name " . "<br>" .
      "Delete command executed successfully";
    } else {
      echo "Error deleting entry: " . $conn->error;
    }
  }
  else if(isset($_POST['reviewer'])){
    $rid = $_POST['r_id'];

    $sql = "DELETE FROM video_game_reviewer WHERE `video_game_reviewer`.`ID` = '$rid'";
    
    if ($conn->query($sql)) {
      echo "Reviewer deleted had id: $rid " . "<br>" .
      "Delete command executed successfully";
    } else {
      echo "Error deleting entry: " . $conn->error;
    }
  }
  else if(isset($_POST['consumer'])){
    $cid = $_POST['c_id'];

    $sql = "DELETE FROM consumer WHERE `consumer`.`ID` = '$cid'";
    
    if ($conn->query($sql)) {
      echo "Reviewer deleted had id: $cid " . "<br>" .
      "Delete command executed successfully";
    } else {
      echo "Error deleting entry: " . $conn->error;
    }
  }

  
?>