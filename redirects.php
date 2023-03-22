<?php
if(isset($_POST['insert'])) {
  header("Location: http://localhost/videogame-sql/insert/insert.html");
} else if (isset($_POST['delete'])) {
    header("Location: http://localhost/videogame-sql/delete/delete.html");
} else if (isset($_POST['update'])) {
    header("Location: http://localhost/videogame-sql/update/update.html");
} else if (isset($_POST['select'])) {
    header("Location: http://localhost/videogame-sql/select/select.html");
} else if (isset($_POST['project'])) {
    header("Location: http://localhost/videogame-sql/project/project.html");
} else if (isset($_POST['join'])) {
    header("Location: http://localhost/videogame-sql/join/join.html");
} else if (isset($_POST['aggregate'])) {
    header("Location: http://localhost/videogame-sql/aggregate/aggregate.html");
} else if (isset($_POST['nested'])) {
    header("Location: http://localhost/videogame-sql/nest/nest.html");
} else if (isset($_POST['divide'])) {
    header("Location: http://localhost/videogame-sql/divide/divide.html");
}
  
?>