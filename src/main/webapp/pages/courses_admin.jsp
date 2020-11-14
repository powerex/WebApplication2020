<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.sql.*" %>
<%@ page import="db.ConnectionFactory" %>
<%@ page import="model.Subject" %>
<%@ page import="dao.SubjectDaoImpl" %>
<%@ page import="dao.SubjectDao" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.LecturersDao" %>
<%@ page import="dao.LecturerDaoImpl" %>
<%@ page import="model.Lecturer" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Map" %>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (request.getParameter("submit") != null) {
        String title = request.getParameter("course");
        int lecturerId = Integer.parseInt(request.getParameter("lecturer"));
        int credit = Integer.parseInt(request.getParameter("credit"));
        Subject subject = new Subject(0, title, lecturerId, credit);
        new SubjectDaoImpl().saveSubject(subject);

    }
%>

<fmt:setBundle basename="message"/>
<fmt:setLocale value="${cookie['lang'].value}" scope="application"/>

<html>
<head>
    <title><fmt:message key="site_title"/></title>

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
    <!-- Bootstrap core CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">

    <style>
        @import "../styles/dropbox.css";
        @import "../bootstrap/css/bootstrap.css";
        @import "../bootstrap/css/bootstrap.min.css";
    </style>
</head>
<body>

<%
    request.setAttribute("list", new LecturerDaoImpl().listNames());
%>

<div style="padding: 20px">

    <h1><fmt:message key="site_title"/></h1>
    <div class="row">
        <div class="col-sm-4">
            <form method="post" action="#">
                </br>
                <div align="left">
                    <label class="form-label"><fmt:message key="title"/></label>
                    <input type="text" class="form-control" placeholder=
                    <fmt:message key="entity.title"/> name="course" id="course"
                           required>
                </div>
                <div align="left">
                    <label class="form-label"><fmt:message key="entity.lecturer"/></label>

                    <select class="form-control" name="lecturer" id="lecturer" required>
                        <c:forEach items="${list}" var="lecturer">
                            <option value="${lecturer.key}">${lecturer.value}</option>
                        </c:forEach>
                    </select>

                </div>
                <div align="left">
                    <label class="form-label"><fmt:message key="entity.credits"/></label>
                    <input type="number" class="form-control" placeholder=
                    <fmt:message key="entity.credits"/> name="credit" id="credit" required>
                </div>
                </br>
                <div align="rigth">
                    <input type="submit" id="submit" value=
                    <fmt:message key="button.submit"/> name="submit" class="btn btn-info">
                    <input type="reset" id="reset" value=
                    <fmt:message key="button.cancel"/> name="reset" class="btn btn-warning">
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
                        SubjectDao subjectDao = new SubjectDaoImpl();
                        List<Subject> subjectList = subjectDao.listSubjects();
                        for (Subject s: subjectList) {
                                %>
                    <tr>
                        <td><%=s.getTitle()%>
                        </td>
                        <td><%=s.getLecturer()%>
                        </td>
                        <td align="center"><%=s.getCredits()%>
                        </td>
                        <td align="center"><a href="/update?id=<%=s.getId()%>"><img
                                src="../images/edit.png" alt="Edit" width="24"></a></td>
                        <td align="center"><a href="/delete?id=<%=s.getId()%>"><img
                                src="../images/delete.png" alt="Delete" width="24"></a></td>
                    </tr>

                        <%
                        }
                    %>
                </table>
            </div>
        </div>lecturers
    </div>
</div>

<div>
    <h5>
        <fmt:message key="cookie.ChooseLocale"/>
    </h5>
    <ul>
        <%--        <li><a href="?cookieLocale=en_US"><fmt:message key="lang.en" /></a></li>--%>
        <li><a href="confirm?cookieLocale=en_US"><fmt:message key="lang.en"/></a></li>
        <%--        <li><a href="?cookieLocale=uk_UA"><fmt:message key="lang.ua" /></a></li>--%>
        <li><a href="confirm?cookieLocale=uk_UA"><fmt:message key="lang.ua"/></a></li>
        <li><a href="confirm?cookieLocale=de_DE"><fmt:message key="lang.de"/></a></li>
    </ul>
</div>

<form action="/logout" method="get">
    <input type="submit" value=
    <fmt:message key="user.logout"/> id="frm1_submit"/>
</form>

</body>
</html>
