<?php
if(isset($_POST['insert'])) {
  header("Location: http://localhost/insert/insert.html");
} else if (isset($_POST['delete'])) {
    header("Location: http://localhost/delete.html");
} else if (isset($_POST['update'])) {
    header("Location: http://localhost/update.html");
} else if (isset($_POST['select'])) {
    header("Location: http://localhost/select.html");
} else if (isset($_POST['project'])) {
    header("Location: http://localhost/project.html");
} else if (isset($_POST['join'])) {
    header("Location: http://localhost/join.html");
} else if (isset($_POST['aggregate'])) {
    header("Location: http://localhost/aggregate.html");
} else if (isset($_POST['nested'])) {
    header("Location: http://localhost/nest.html");
} else if (isset($_POST['divide'])) {
    header("Location: http://localhost/divide.html");
}
  
?>