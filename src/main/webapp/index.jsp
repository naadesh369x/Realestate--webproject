<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login Redirect</title>
</head>
<body>

<%
  // Immediately redirect to main immersive landing page
  response.sendRedirect(request.getContextPath() + "/pages/common/mainpage.jsp");
%>

</body>
</html>
