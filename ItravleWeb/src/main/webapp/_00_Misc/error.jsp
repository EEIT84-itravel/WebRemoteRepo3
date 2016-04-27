<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><title>error</title></head>
<body bgcolor="#99ccff">
    
    <img src="<%=request.getContextPath() %>/img/error.jpg" width="400"><br>
    <font><b>糟糕，網路忙線中...</b></font>
    
    <h3>Exception:</h3>
    <%= exception %>

    <h3>Stack trace:</h3>
    <pre>
    <%
//     	exception.printStackTrace(new PrintWriter(out));
    %>
    </pre>
</body>
</html>