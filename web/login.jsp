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
    <input  type="button" value="En" class="btn btn-default btn-sm" onclick="setLocalEN();"/>  
    <input  type="button" value="简" class="btn btn-default btn-sm" onclick="setLocalCN();"/>  
    <input  type="button" value="繁" class="btn btn-default btn-sm" onclick="setLocalHK();"/>  
</div>  
<fmt:bundle basename="${lan}">
        
    
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link rel="stylesheet" href="resources/css/style_login.css" type="text/css" media="all" />
<div class="container">
<h1><fmt:message key="login.label.loginform"/></h1>
	<div class="signin">
     	<form>
	      	<input type="text" class="user" value="<fmt:message key="login.label.username"/>" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '<fmt:message key="login.label.username"/>';}" />
	      	<input type="password" class="pass" />
          	<input type="submit" value="<fmt:message key="login.label.submit"/>" />
	 	</form>
	</div>
</div>
<div class="footer">
     <p>Copyright &copy; 2016 All Rights Reserved</p>
</div>
</fmt:bundle>