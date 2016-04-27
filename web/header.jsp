<%-- 
    Document   : header
    Created on : Apr 9, 2016, 8:57:48 PM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=gb2312" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="lan" value="com.ss.i18n.T4uUI" scope="application" />
<fmt:setLocale value="en_US" />
<!DOCTYPE html>
<html>
    <%  String varLocal = request.getParameter("locale");  
        if (varLocal == null || varLocal.equals("")) { 
        } 
        else if ("zh_CN".equalsIgnoreCase(varLocal)) {%>  
        <fmt:setLocale value="zh_CN" scope="session" />  
    <%    } else if ("en_US".equalsIgnoreCase(varLocal)){%>  
        <fmt:setLocale value="en_US" scope="session" />  
    <%    } else {%>  
        <fmt:setLocale value="zh_HK" scope="session" />  
    <%    } %>  
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Disclaimer:This web site exists to fulfill the coursework requirement of CS4280.Do not use your real personal data as input.">
        <title>Cinema</title>
        <!-- ########## JS ########## -->
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/md5.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/common.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/notify.min.js"></script>
        <!-- ########## CSS ########## -->
        <!--
        <link href="../resources/bootstrap-3.3.6/css/bootstrap.min.css" rel="stylesheet"/>
        -->
        <link href="/T4U/resources/css/common.css" rel="stylesheet"/>
    </head>
    <body>
