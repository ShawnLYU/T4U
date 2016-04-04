<%-- 
    Document   : index
    Created on : Apr 4, 2016, 10:15:05 AM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=gb2312" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="lang" value="en" scope="session" />
<fmt:setLocale value="${lang}" />
<fmt:setBundle basename="com.ss.i18n" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!--<h1><fmt:message key="test.index.hello"/></h1>-->
        <!--
        <c:set var="salary" scope="session" value="${2000*2}"/>
        <c:if test="${salary > 2000}">
            <p>My salary is: <c:out value="${salary}"/><p>
        </c:if>
        -->
        
        
        <c:set var="todayValue" value="<%=new Date() %>"/>
        中文－大陆:<fmt:setLocale value="zh_CN"/> <fmt:formatDate value="${todayValue}"/><br>
        英文:<fmt:setLocale value="en_US"/> <fmt:formatDate value="${todayValue}"/>
        <fmt:setLocale value="zh_CN"/>           <!--指定区域语言-->
        <fmt:bundle basename="com.ss.i18n.T4uUI">
           <fmt:message key="test.index.hello"/>
        </fmt:bundle>
    </body>
</html>
