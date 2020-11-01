<%@ page contentType="text/html;charset=UTF-8"%>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (request.getParameter("submit") != null) {
        String title = request.getParameter("course");
        String cname = request.getParameter("cname");
        String credit = request.getParameter("credit");

        if (title != null && cname != null && credit != null) {
            Connection connection = null;
            PreparedStatement pst;

            try {
                connection = ConnectionFactory.getConnection();
                pst = connection.prepareStatement("insert into subjects(title, lecturer, credits) values (?,?,?)");
                pst.setString(1, title);
                pst.setString(2, cname);
                int cr = Integer.parseInt(credit);
                pst.setInt(3, cr);
                pst.executeUpdate();
                connection.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
%>

<fmt:setBundle basename="message" />
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

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
    <h1><fmt:message key="site_title" /></h1>
    <div class="row">
        <div class="col-sm-4">
            <form method="post" action="#">
                <div align="left">
                    <label for="course" class="form-label">Назва курсу</label>
                    <input type="text" class="form-control" placeholder="Назва курсу" name="course" id="course"
                                                       required>
                </div>
                <div align="left">
                    <label for="cname" class="form-label">Викладач</label>
                    <input type="text" class="form-control" placeholder="Викладач" name="cname" id="cname" required>
                </div>
                <div align="left">
                    <label for="credit" class="form-label">Кредити</label>
                    <input type="number" class="form-control" placeholder="Кредити" name="credit" id="credit" required>
                </div>
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
                        <th><fmt:message key="entity.title"/></th>
                        <th><fmt:message key="entity.lecturer"/></th>
                        <th><fmt:message key="entity.credits"/></th>
                        <th><fmt:message key="data.edit"/></th>
                        <th><fmt:message key="data.delete"/></th>
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

<div>
    <h5>
        <fmt:message key="cookie.ChooseLocale" />
    </h5>
    <ul>
        <%--        <li><a href="?cookieLocale=en_US"><fmt:message key="lang.en" /></a></li>--%>
        <li><a href="confirm?cookieLocale=en_US"><fmt:message key="lang.en" /></a></li>
        <%--        <li><a href="?cookieLocale=uk_UA"><fmt:message key="lang.ua" /></a></li>--%>
        <li><a href="confirm?cookieLocale=uk_UA"><fmt:message key="lang.ua" /></a></li>
    </ul>
</div>

<form action="/logout" method="get">
    <input type="submit" value="Вийти" id="frm1_submit" />
</form>


</body>
</html>
