<%-- web/login.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>用户登录</title></head>
<body>
    <h2>高校实验室预约系统</h2>

    <%-- 显示错误信息 --%>
    <% if(request.getAttribute("errorMsg") != null) { %>
        <p style="color:red;">${errorMsg}</p>
    <% } %>

    <%-- action="/login" 对应 LoginServlet 的 @WebServlet("/login") --%>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <p>用户名：<input type="text"     name="username" /></p>
        <p>密　码：<input type="password" name="password" /></p>
        <p><button type="submit">登录</button></p>
    </form>
</body>
</html>