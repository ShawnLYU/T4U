<%-- 
    Document   : footer
    Created on : Apr 9, 2016, 9:30:11 PM
    Author     : mengxualv2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:bundle basename="${lan}">
        <div class="footer">
            <p>Copyright &copy; 2016 All Rights Reserved</p>
            <p><fmt:message key="footer.disclaimer"/></p>
            <p class="claim"><fmt:message key="footer.disclaimer.e1"/></p>
            <p><fmt:message key="footer.disclaimer.e2"/></p>
            <div class="copyright">
                    <p> <fmt:message key="footer.fork"/>  <a href="http://shawnlyu.github.io/T4U/">  github.com/ShawnLYU/T4U </a></p>
            </div>
        </div>
    </body>
</html>
</fmt:bundle>
