<%--
  Created by IntelliJ IDEA.
  User: Tuf
  Date: 3/24/2025
  Time: 8:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="/views/header.jsp" %>
<h1>Hello user!!!</h1>

<form action="${pageContext.request.contextPath}/logout" method="GET">
  <button type="submit">Log Out</button>
</form>

<%@ include file="/views/footer.jsp" %>
</body>
</html>
