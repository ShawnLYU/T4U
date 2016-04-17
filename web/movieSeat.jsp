<%-- 
    Document   : seatPlan
    Created on : Apr 11, 2016, 8:41:10 PM
    Author     : Steven
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
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/common.js"></script>
        <script type="text/javascript" src="/T4U/resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/T4U/resources/js/jquery.flexisel.js"></script>	

        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<!--        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />-->
    </head>
    <body>
        <div class="col-sm-8 col-sm-offset-2">
            <fmt:bundle basename="${lan}">
            <!-- header-section-starts -->
            <div class="full">
                <div class="main" style="border-left:0;">
                    <div class="error-content">
                        <div class="top-header span_top">
                            <div class="logo">
                                    <a href="index.jsp"><img src="/T4U/resources/images/logo.png" alt="" /></a>
                                    <p>Movie Theater</p>
                            </div>
                            <div class="search" style="width:30%">
                                <div  class="btn-group col-sm-6" role="group">
                                    <button type="button" class="btn btn-default col-sm-4" onclick="setLocaleEN();">En</button>
                                    <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleCN();">简</button>
                                    <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleHK();">繁</button>

                                </div>  
                                <div class="dropdown col-sm-6" style="padding: 0;">
                                    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${sessionScope.t4uUser != null}">
                                           <c:out value="${sessionScope.t4uUser.userName}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:message key="index.label.account"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="caret"></span></button>
                                    <ul class="dropdown-menu">
                                        <c:choose>
                                            <c:when test="${sessionScope.t4uUser != null}">
                                               <li><a href="#"><fmt:message key="index.label.profile"/></a></li>
                                            </c:when>
                                            <c:otherwise>
                                               <li><a href="/T4U/login.jsp"><fmt:message key="index.label.login"/></a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    <li><a href="/T4U/register.jsp"><fmt:message key="index.label.register"/></a></li>
                                    <li class="divider"></li>
                                    <li><a href="/T4U/user/logout.do"><fmt:message key="index.label.logout"/></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="error-404 text-center">
                            
                        </div>		
                    </div>
                </div>
                </fmt:bundle>
                <jsp:include page="footer_normal.jsp" />
                