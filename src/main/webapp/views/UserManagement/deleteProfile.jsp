<%@ page import="com.toyStore.util.UserManagement.FileUtil" %>

<%
    String email = request.getParameter("email");
    boolean isDeleted = FileUtil.removeUser(email);

    if (isDeleted) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    } else {
        out.println("<script>alert('Error deleting account.'); window.history.back();</script>");
    }
%>
