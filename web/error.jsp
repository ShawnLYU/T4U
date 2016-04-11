<%-- 
    Document   : error
    Created on : Apr 11, 2016, 8:41:10 PM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="lan" value="com.ss.i18n.T4uUI" scope="application" />
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cinema</title>
        <!-- start plugins -->
        <script src="resources/js/jquery-1.11.1.min.js"></script>
        <script src="resources/js/jquery.validate.min.js"></script>
        <script src="resources/js/additional-methods.js"></script>
        <script src="resources/js/notify.min.js"></script>
        <script src="resources/js/common.js"></script>


        <link href="resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />
    </head>
    <body>
        <fmt:bundle basename="${lan}">
        <!-- header-section-starts -->
	<div class="full">
	<div class="main" style="border-left:0;">
            <div class="error-content">
                <div class="top-header span_top">
                    <div class="logo">
                            <a href="index.html"><img src="resources/images/logo.png" alt="" /></a>
                            <p>Movie Theater</p>
                    </div>
                    <div class="search v-search">
                        <div  class="btn-group" role="group">
                            <button type="button" class="btn btn-default" onclick="setLocaleEN();">En</button>
                            <button type="button" class="btn btn-default" onclick="setLocaleCN();">简</button>
                            <button type="button" class="btn btn-default" onclick="setLocaleHK();">繁</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="error-404 text-center">
                    <p><fmt:message key="error.login.e2"/></p>
                    <a class="b-home" href="index.html"><fmt:message key="error.register.backHome" /></a>
                </div>		
            </div>
	</div>
        </fmt:bundle>
        <jsp:include page="footer.jsp" />
