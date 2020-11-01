<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>
<div style="display: block; margin: auto; width: 300px; height: 200px">
<form method="post" action="">
    </br>
    <div align="left">
        <label for="login" class="form-label">Логін</label>
        <input type="text" class="form-control" placeholder="Логін" name="login" id="login"
               required>
    </div>
    <div align="left">
        <label for="pwd" class="form-label">Пароль</label>
        <input type="text" class="form-control" placeholder="Пароль" name="pwd" id="pwd" required>
    </div>
    <br>
    <div align="rigth">
        <input type="submit" value="Увійти" class="btn btn-info">
    </div>
</form>
</div>
</body>
</html>
