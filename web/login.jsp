<%-- 
    Document   : login
    Created on : Apr 9, 2016, 8:30:49 PM
    Author     : mengxualv2
--%>
<%@page language="java" contentType="text/html;charset=gb2312" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div align='right'>  
    <form action="setLocale.do" method="post"><input  type="hidden" name="locale" value="en_US"/><input type="submit" value="En"/></form>  
    <form action="setLocale.do" method="post"><input  type="hidden" name="locale" value="zh_CN"/><input type="submit" value="简"/></form> 
    <form action="setLocale.do" method="post"><input  type="hidden" name="locale" value="zh_HK"/><input type="submit" value="繁"/></form>  
</div>  
<fmt:bundle basename="${lan}">
        
    
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link rel="stylesheet" href="resources/css/style_login.css" type="text/css" media="all" />
<div class="container">
<h1><fmt:message key="login.label.loginform"/></h1>
	<div class="signin">
     	<form>
	      	<input type="text" name="userAccout" class="user" value="<fmt:message key="login.label.username"/>" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '<fmt:message key="login.label.username"/>';}" />
	      	<input type="password" name="pwd" class="pass" />
          	<input type="submit" value="<fmt:message key="login.label.submit"/>" />
	 	</form>
	</div>
</div>
<div class="footer">
     <p>Copyright &copy; 2016 All Rights Reserved</p>
</div>
</fmt:bundle>