<%-- 
    Document   : single
    Created on : Apr 13, 2016, 2:47:10 PM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="com.ss.i18n" />
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
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cinema</title>
        <!-- start plugins -->
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/common.js"></script>
        <script type="text/javascript" src="/T4U/resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/T4U/resources/js/jquery.flexisel.js"></script>
        <script src="/T4U/resources/js/jquery.dataTables.min.js"></script>
        <script src="/T4U/resources/js/notify.min.js"></script>
        
        
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap-theme.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_index.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href="/T4U/resources/css/jquery.dataTables.min.css" rel="stylesheet"/>
    </head>
    <fmt:bundle basename="${lan}">
    <body>
		<div class="col-sm-8 col-sm-offset-2">
			<!-- header-section-starts -->
			<div class="full">
				<div class="menu">
				</div>
				<div class="main">
					<div class="single-content">
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
						<div class="reviews-section">
							<h4><fmt:message key="movieDetail.label.info"/></h4>
                                                                        <table id="example" class="display col-sm-8 col-sm-offset-2" cellspacing="0" width="100%">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th><fmt:message key="movieDetail.table.head.cinemaName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.houseName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.versionName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.scheduleTimeslot"/></th>
                                                                                    <th><fmt:message key="profile.orderTable.orderCash"/></th>
                                                                                    <th><fmt:message key="movieDetail.button.ticketing"/></th>
                                                                                </tr>
                                                                            </thead>
                                                                            
                                                                            <tbody>
                                                                                <c:forEach items="${sessionScope.T4uCart}" var="order" varStatus="loop">
                                                                                    <tr id='${loop.index}'>
                                                                                        <td><c:out value="${order.schedule.house.cinema.cinemaName}"/></td>
                                                                                        <td><c:out value="${order.schedule.house.houseName}"/></td>
                                                                                        <td><c:out value="${order.schedule.version.versionName}"/></td>
                                                                                        <td><c:out value="${order.schedule.scheduleTimeslot}"/></td>
                                                                                        <td><c:out value="${order.orderCash}" /></td>
                                                                                        <td><input type="button" class="btn btn-primary" value="<fmt:message key="movieDetail.button.ticketing"/>" title="Ticketing" onclick="paySingle(${loop.index})" /></td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                            <tfoot>
                                                                                <tr>
                                                                                    <th><fmt:message key="movieDetail.table.head.cinemaName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.houseName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.versionName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.scheduleTimeslot"/></th>
                                                                                    <th><fmt:message key="profile.orderTable.orderCash"/></th>
                                                                                    <th><fmt:message key="movieDetail.button.ticketing"/></th>
                                                                                </tr>
                                                                            </tfoot>
                                                                        </table>
                                                                                <button type="button" id="all" class="btn btn-warning"><fmt:message key="cart.payAll"/></button>        
							<div class="col-md-12 reviews-grids">
								<div class="review">
								<div class="single">
								</div>
								<div class="best-review">
									
								</div>
				  			</div>

							<div class="clearfix"></div>
						</div>
					</div>
                                </div>
<script>
$(document).ready(function(){
//    constructDataTable($("#sel1").val());
    $('#example').DataTable({
                    "oSearch": {"bSmart": false}
                });
    $("#all").click(function(){
        $.ajax({
        url : '/T4U/CartPay',
        type: "POST",
        data : {
                action: 'all'
       },

        error : function(data) {
                $("td").remove();
        },
        success : function(xhr) {
                $("td").remove();
        }
    });
    });
    
});
function showErrorMessage(msg){
        $.notify(msg, {
                        globalPosition: "top left",
                        autoHideDelay: 5000});
}
function showSuccessMessage(msg){
        $.notify(msg, {
                        globalPosition: "top left",
                        autoHideDelay: 5000,
                    className: 'success',});
}
function paySingle(aIndex){
    $.ajax({
        url : '/T4U/CartPay',
        type: "POST",
        data : {
                index : aIndex,
                action: 'single'
       },

        error : function(data) {
                alert(data);
        },
        success : function(xhr) {
                var id = xhr;
                $("body").find('#' + id).remove();
                showSuccessMessage('<fmt:message key="cart.label.paySueecss"/>');
        }
    });
    
    
}

</script>
</fmt:bundle>
    <jsp:include page="footer_normal.jsp" />