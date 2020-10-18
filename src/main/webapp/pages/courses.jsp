<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>

<%
    if (request.getParameter("submit") != null) {
        String title = request.getParameter("course");
        String cname = request.getParameter("cname");
        String credit = request.getParameter("credit");

        Connection connection = null;
        PreparedStatement pst;

        try {
            connection = ConnectionFactory.getConnection();
            pst = connection.prepareStatement("insert into subjects(title, lecturer, credits) values (?,?,?)");
            pst.setString(1, title);
            pst.setString(2, cname);
            Integer cr = Integer.valueOf(credit);
            pst.setInt(3, cr);
            pst.executeUpdate();
            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
%>

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
        <div class="col-sm-4">
            <form method="post" action="#">
                </br>
                <div align="left">
                    <label class="form-label">Назва курсу</label>
                    <input type="text" class="form-control" placeholder="Назва курсу" name="course" id="course"
                           required>
                </div>
                <div align="left">
                    <label class="form-label">Викладач</label>
                    <input type="text" class="form-control" placeholder="Викладач" name="cname" id="cname" required>
                </div>
                <div align="left">
                    <label class="form-label">Кредити</label>
                    <input type="number" class="form-control" placeholder="Кредити" name="credit" id="credit" required>
                </div>
                </br>
                <div align="rigth">
                    <input type="submit" id="submit" value="Підтвердити" name="submit" class="btn btn-info">
                    <input type="reset" id="reset" value="Скасувати" name="reset" class="btn btn-warning">
                </div>
            </form>
        </div>

        <div class="col-sm-8">
            <div class="panel-body">
                <table id="tbl-subjects" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                    <thead>
                    <tr>
                        <th>Назва курсу</th>
                        <th>Викладач</th>
                        <th>Кредити</th>
                        <th>Редагувати</th>
                        <th>Вилучити</th>
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
                        <td align="center"><a href="/update?id=<%=resultSet.getInt("id")%>"><img
                                src="../images/edit.png" alt="Edit" width="24"></a></td>
                        <td align="center"><a href="/delete?id=<%=resultSet.getInt("id")%>"><img
                                src="../images/delete.png" alt="Delete" width="24"></a></td>
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
</body>
</html>
