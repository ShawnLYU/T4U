<%-- 
    Document   : login
    Created on : Apr 9, 2016, 8:30:49 PM
    Author     : mengxualv2
--%>
<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />
<fmt:bundle basename="${lan}">
    <link rel="stylesheet" href="resources/css/style_login.css" type="text/css" media="all" />
<div align='right'>  
    <input type="button" value="En" style="width:2%;" onclick="setLocaleEN();"/>
    <input type="button" value="简" style="width:2%;" onclick="setLocaleCN();"/>
    <input type="button" value="繁" style="width:2%;" onclick="setLocaleHK();"/>
</div> 


<script type="application/x-javascript">
    addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){
        window.scrollTo(0,1);
    }
</script>
<div class="container">
<h1><fmt:message key="login.label.loginform"/></h1>
    <div class="signin">
        <form action="login.do" method="POST" onsubmit="return hashPassword(this);">
            <input type="text" name="userAccount" class="user" value="<fmt:message key="login.label.username"/>" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '<fmt:message key="login.label.username"/>';}" />
            <input type="password" name="userPassword" class="pass" />
            <input type="submit" value="<fmt:message key="login.label.submit"/>" />
        </form>
    </div>
</div>

</fmt:bundle>
<jsp:include page="footer.jsp" />