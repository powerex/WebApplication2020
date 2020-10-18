<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>

<%
    if (request.getParameter("submit") != null) {
        Integer id = Integer.valueOf(request.getParameter("id"));
        String title = request.getParameter("course");
        String cname = request.getParameter("cname");
        String credit = request.getParameter("credit");

        Connection connection;
        PreparedStatement pst;

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/webdb", "postgres", "postgres");
            pst = connection.prepareStatement("update subjects set title = ?, lecturer = ?, credits = ? where id = ?");
            pst.setString(1, title);
            pst.setString(2, cname);
            Integer cr = Integer.valueOf(credit);
            pst.setInt(3, cr);
            pst.setInt(4, id);
            pst.executeUpdate();
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        response.sendRedirect("/");
    }

    if (request.getParameter("reset") != null) {
        response.sendRedirect("/");
    }
%>


<html>
<head>
    <title>Редагування</title>
    <style>
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>
<h1>Оновлення даних</h1>
<div class="row">
    <div class="col-sm-4">
        <form method="post" action="#">

            <%
                Connection connection;
                PreparedStatement pst;
                ResultSet resultSet;

                try {
                    Class.forName("org.postgresql.Driver");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                try {
                    connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/webdb", "postgres", "postgres");
                    Integer id = Integer.valueOf(request.getParameter("id"));
                    pst = connection.prepareStatement("select * from subjects where id = ?");
                    pst.setInt(1, id);
                    resultSet = pst.executeQuery();
                    while (resultSet.next()) {
            %>

            </br>
            <div align="left">
                <label class="form-label">Назва курсу</label>
                <input type="text" class="form-control" placeholder="Назва курсу" value="<%=resultSet.getString("title")%>" name="course" id="course" required>
            </div>
            <div align="left">
                <label class="form-label">Викладач</label>
                <input type="text" class="form-control" placeholder="Викладач" value="<%=resultSet.getString("lecturer")%>" name="cname" id="cname" required>
            </div>
            <div align="left">
                <label class="form-label">Кредити</label>
                <input type="text" class="form-control" placeholder="Кредити" value="<%=resultSet.getInt("credits")%>" name="credit" id="credit" required>
            </div>

            <%
                    }
                    connection.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            %>
            </br>
            <div align="rigth">
                <input type="submit" id="submit" value="Підтвердити" name="submit" class="btn btn-info">
                <input type="reset" id="reset" value="Скасувати" name="reset" class="btn btn-warning" onclick="location.href='/'">
            </div>
        </form>
    </div>
</div>
</body>
</html>
