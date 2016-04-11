<%-- 
    Document   : index
    Created on : Apr 4, 2016, 10:15:05 AM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=gb2312" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="com.ss.i18n" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        
        <c:set var="todayValue" value="<%=new Date() %>"/>
        中文－大陆:<fmt:setLocale value="zh_CN"/> <fmt:formatDate value="${todayValue}"/><br>
        英文:<fmt:setLocale value="en_US"/> <fmt:formatDate value="${todayValue}"/>
<jsp:include page="footer.jsp" />
