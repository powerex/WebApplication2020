<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>

<%@ page isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        response.sendRedirect("/courses");
    }
%>

<fmt:setBundle basename="message" />
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

<html>
<head>
    <title>Редагування</title>
    <style>
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>
<h1><fmt:message key="data.update"/></h1>
<div class="row">
    <div class="col-sm-4">
        <form method="post" action="#">

            <%
                Connection connection;
                PreparedStatement pst;
                ResultSet resultSet;
                try {
                    connection = ConnectionFactory.getConnection();
                    Integer id = Integer.valueOf(request.getParameter("id"));
                    pst = connection.prepareStatement("select * from subjects where id = ?");
                    pst.setInt(1, id);
                    resultSet = pst.executeQuery();
                    while (resultSet.next()) {
            %>

            </br>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.title"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="entity.title"/> value="<%=resultSet.getString("title")%>" name="course" id="course" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.lecturer"/></label>
                <input type="text" class="form-control" placeholder=<fmt:message key="entity.lecturer"/> value="<%=resultSet.getString("lecturer")%>" name="cname" id="cname" required>
            </div>
            <div align="left">
                <label class="form-label"><fmt:message key="entity.credits"/></label>
                <input type="number" class="form-control" placeholder=<fmt:message key="entity.credits"/> value="<%=resultSet.getInt("credits")%>" name="credit" id="credit" required>
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
                <input type="submit" id="submit" value=<fmt:message key="button.submit"/> name="submit" class="btn btn-info">
                <input type="reset" id="reset" value=<fmt:message key="button.cancel"/> name="reset" class="btn btn-warning" onclick="location.href='/courses'">
            </div>
        </form>
    </div>
</div>
</body>
</html>
