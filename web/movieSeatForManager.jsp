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
<c:set var="allSchedules" value="${requestScope.t4uAllSchedules}" />
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
        <script src="/T4U/resources/js/notify.min.js"></script>

        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<!--        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />-->
        <!-- jQuery Seat Plan -->
        <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
        <link href="/T4U/resources/css/jquery.seat-charts.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/T4U/resources/css/style_seat.css" rel="stylesheet" type="text/css" media="all" />
        <script src="/T4U/resources/js/jquery.seat-charts.js"></script>
        
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
                                    <a href="${pageContext.request.contextPath}/index"><img src="/T4U/resources/images/logo.png" alt="" /></a>
                                    <p>Movie Theater</p>
                            </div>
                            <div class="search" style="width:30%">
                                <div  class="btn-group col-sm-6" role="group">
                                    <button type="button" class="btn btn-default col-sm-4" onclick="setLocaleEN();">En</button>
                                    <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleCN();">简</button>
                                    <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleHK();">繁</button>

                                </div>  
                                <%@include file="userDropDownMenu.jsp" %>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="error-404">
                            <div class="wrapper">
                                <div class="container">
                                    <div class="row">
                                        <form role="form">
                                            <div class="form-group">
                                              <label for="sel1"><fmt:message key="seatPlan.selectSchedule"/>:</label>
                                              <select class="form-control" id="sel1">
                                                <c:forEach items="${allSchedules}" var="schedule">
                                                    <option value="${schedule.scheduleId}">
                                                        ${schedule.version.movie.movieName}&nbsp;
                                                        ${schedule.version.versionName}&nbsp;－&nbsp;
                                                        ${schedule.house.cinema.cinemaName}&nbsp;
                                                        ${schedule.house.houseName}&nbsp;－&nbsp;
                                                        ${schedule.scheduleTimeslot}
                                                    </option>
                                                </c:forEach>
                                              </select>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="row">
                                        <div id="seat-map">
                                            <div class="front-indicator"><fmt:message key="seat.label.screen"/></div>
                                        </div>
                                        <div class="booking-details">
                                            <div id="legend"></div>
                                            <h2><fmt:message key="seat.label.detail"/></h2>
                                            <h3> <fmt:message key="seat.label.selected"/> (<span id="counter">0</span>):</h3>
                                            <ul id="selected-seats" class="list-group"></ul>
                                            <fmt:message key="seat.label.total"/>: <b>$<span id="total">0</span></b>
                                            <button id="pay" class="btn btn-info checkout-button"><fmt:message key="seat.label.checkout"/> &raquo;</button>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <form id="myForm" method="POST" action = "/T4U/confirm"></form>  
                            <script>
                                function showErrorMessage(msg){
                                        $.notify(msg, {
                                                        globalPosition: "top left",
                                                        autoHideDelay: 5000});
                                }
                                $("#sel1").change(function(){
                                    $.ajax({
                                            url : 'getSeatPlan',
                                            data : {
                                                    scheduleId : $("#sel1").val()
                                            },
                                            error : function(xhr) {
                                                    alert('Error');
                                            },
                                            success : function(responseText) {
                                                    alert('Success');
                                                    //eval(responseText);
                                            }
                                    });
                                });
                            </script>
                        </div>		
                    </div>
                </div>
                </fmt:bundle>
                <jsp:include page="footer_normal.jsp" />
                