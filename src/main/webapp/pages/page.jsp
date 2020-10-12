<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello from JSP</title>
    <style>
        @import "../styles/main.css" screen;
    </style>
</head>
<body>
<h1>JSP</h1>
<%@ page import="java.util.Date" %>
<%@ page import="logic.BusinessLogic" %>
<% Date now = new Date(); %>
<%= now %>

<% for (int i=0; i<10; i++) {
    out.println("<p>" + "Loop number is: " + i + "</p>");
}%>

<%
    BusinessLogic bl = new BusinessLogic();
    out.println("<div><b>" + bl.getString() + "</b></div>");
%>

<%

    String name = request.getParameter("name");
    if (name != null) {
        out.println("<div><b>Hello, " + name + "</b></div>");
    }

%>
</body>
</html>
