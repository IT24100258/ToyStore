<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Admin Home</title>
</head>
<body>
<h1>Welcome Admin</h1>

<ul>
  <li><a href="${pageContext.request.contextPath}/views/admin/addAdmin.jsp">Add New Admin</a></li>
  <li><a href="${pageContext.request.contextPath}/viewAdmins">View All Admins</a></li>
</ul>

<a href="${pageContext.request.contextPath}/logout">Logout</a>
</body>
</html>
