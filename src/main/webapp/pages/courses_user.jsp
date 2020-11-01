<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>

<html>
<head>
    <title>Навчальні курси</title>
    <style>
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>
<div style="padding: 20px">
    <h1>Навчальні курси</h1>
    <div class="row">
        <div class="col-sm-8">
            <div class="panel-body">
                <table id="tbl-subjects" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                    <thead>
                    <tr>
                        <th>Назва курсу</th>
                        <th>Викладач</th>
                        <th>Кредити</th>
                    </tr>

                        <%
                        Connection connection = ConnectionFactory.getConnection();
                        ResultSet resultSet;

                        try {
                            resultSet = connection.createStatement().executeQuery("select * from subjects order by id");

                            while (resultSet.next()) {
                                %>
                    <tr>
                        <td><%=resultSet.getString("title")%>
                        </td>
                        <td><%=resultSet.getString("lecturer")%>
                        </td>
                        <td align="center"><%=resultSet.getInt("credits")%>
                        </td>
                    </tr>

                        <%
                            }
                            connection.close();
                        } catch (SQLException throwables) {
                            throwables.printStackTrace();
                        }
                    %>
                </table>
            </div>
        </div>
    </div>
</div>

<form action="/logout" method="get">
    <input type="submit" value="Вийти"
           name="Submit" id="frm1_submit" />
</form>
</body>
</html>
