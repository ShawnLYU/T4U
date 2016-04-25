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
<c:set var="selSchedules" value="${requestScope.t4uSelSchedules}" />
<c:set var="allMovies" value="${applicationScope.t4uAllMovies}"/>
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
        
        
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap-theme.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_index.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href="/T4U/resources/css/jquery.dataTables.min.css" rel="stylesheet"/>
        <style type="text/css">
            .modal-content iframe{
                margin: 0 auto;
                display: block;
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function(){
                $('#example').DataTable({
                    "oSearch": {"bSmart": false}
                });
                $("#flexiselDemo1").flexisel({
                    visibleItems: 6,
                    animationSpeed: 1000,
                    autoPlay: true,
                    autoPlaySpeed: 3000,    		
                    pauseOnHover: false,
                    enableResponsiveBreakpoints: true,
                    responsiveBreakpoints: { 
                        portrait: { 
                            changePoint:480,
                            visibleItems: 1
                        }, 
                        landscape: { 
                            changePoint:640,
                            visibleItems: 2
                        },
                        tablet: { 
                            changePoint:768,
                            visibleItems: 3
                        }
                    }
                });
                /* Get iframe src attribute value i.e. YouTube video url
                and store it in a variable */
                var url = $("#cartoonVideo").attr('src');

                /* Assign empty url value to the iframe src attribute when
                modal hide, which stop the video playing */
                $("#myModal").on('hide.bs.modal', function(){
                    $("#cartoonVideo").attr('src', '');
                });

                /* Assign the initially stored url back to the iframe src
                attribute when modal is displayed again */
                $("#myModal").on('show.bs.modal', function(){
                    $("#cartoonVideo").attr('src', url);
                });
            });
        </script>
    </head>
    <fmt:bundle basename="${lan}">
    <body>
		<div class="col-sm-10 col-sm-offset-1">
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
							<h3 class="head"><fmt:message key="movieDetail.label.title"/></h3>
							<div class="col-md-12 reviews-grids">
								<div class="review">
                                                                    <div class="movie-pic">
                                                                            <a href=""><img src="<c:out value="${requestScope.t4uCurMovie.movieInfo.Poster}"/>" alt="" /></a>
                                                                    </div>
                                                                    <div class="review-info">
                                                                        <a class="span" href="">
                                                                            <c:out value="${requestScope.t4uCurMovie.movieName}"/>
                                                                        </a>
                                                                        
                                                                        <div class="yrw">
                                                                            <div class="wt text-center">
                                                                                <a href="#myModal" class="btn btn-lg btn-info col-sm-12" data-toggle="modal"><fmt:message key="index.label.watchTrailer"/></a>
                                                                            </div>
                                                                            <div class="clearfix"></div>
                                                                        </div>
                                                                        <!-- Modal HTML -->
                                                                        <div id="myModal" class="modal fade">
                                                                            <div class="modal-dialog">
                                                                                <div class="modal-content">
                                                                                    <div class="modal-header">
                                                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                                        <h4 class="modal-title">YouTube</h4>
                                                                                    </div>
                                                                                    <div class="modal-body">
                                                                                        <iframe id="cartoonVideo" width="560" height="315" src="//www.youtube.com/embed/${requestScope.t4uCurMovie.movieInfo.Trailer}" frameborder="0" allowfullscreen></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <table class="table table-responsive">
                                                                            <tr><td class="info"><fmt:message key="movieDetail.label.genre"/></td><td><c:out value="${requestScope.t4uCurMovie.movieInfo.Genre}"/></td></tr>
                                                                            <tr><td class="info"><fmt:message key="movieDetail.label.class"/></td><td><c:out value="${requestScope.t4uCurMovie.movieInfo.Class}"/></td></tr>
                                                                            <tr><td class="info"><fmt:message key="movieDetail.label.duration"/></td><td><c:out value="${requestScope.t4uCurMovie.movieInfo.Length}"/></td></tr>
                                                                            <tr><td class="info"><fmt:message key="movieDetail.label.direction"/></td><td><c:out value="${requestScope.t4uCurMovie.movieInfo.Director}"/></td></tr>
                                                                            <tr><td class="info"><fmt:message key="movieDetail.label.cast"/></td><td><c:out value="${requestScope.t4uCurMovie.movieInfo.Cast}"/></td></tr>
                                                                        </table>
                                                                    </div>
                                                                    <div class="clearfix"></div>
								</div>
								<div class="single">
									<h3><fmt:message key="movieDetail.label.story"/></h3>
                                                                        <p><c:out value="${requestScope.t4uCurMovie.movieDescription}"/></p>
								</div>
								<div class="best-review">
									<h4><fmt:message key="movieDetail.label.info"/></h4>
                                                                        <table id="example" class="display col-sm-8 col-sm-offset-2" cellspacing="0" width="100%">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th><fmt:message key="movieDetail.table.head.cinemaName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.houseName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.versionName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.scheduleTimeslot"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.cinemaLocation"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.versionPrice"/></th>
                                                                                    <th><fmt:message key="movieDetail.button.ticketing"/></th>
                                                                                </tr>
                                                                            </thead>
                                                                            
                                                                            <tbody>
                                                                                <c:forEach items="${selSchedules}" var="schedule">
                                                                                    <tr>
                                                                                        <td><c:out value="${schedule.value.house.cinema.cinemaName}"/></td>
                                                                                        <td><c:out value="${schedule.value.house.houseName}"/></td>
                                                                                        <td><c:out value="${schedule.value.version.versionName}"/></td>
                                                                                        <td><c:out value="${schedule.value.scheduleTimeslot}"/></td>
                                                                                        <td><c:out value="${schedule.value.house.cinema.cinemaLocation.district}"/></td>
                                                                                        <td><c:out value="${schedule.value.price}" /></td>
                                                                                        <td><input type="button" class="btn btn-primary" value="<fmt:message key="movieDetail.button.ticketing"/>" title="Ticketing" onclick="location.href='<c:out value="${pageContext.request.contextPath}"/>/movie/seat?scheduleId=<c:out value="${schedule.key}"/>';" /></td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                            <tfoot>
                                                                                <tr>
                                                                                    <th><fmt:message key="movieDetail.table.head.cinemaName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.houseName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.versionName"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.scheduleTimeslot"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.cinemaLocation"/></th>
                                                                                    <th><fmt:message key="movieDetail.table.head.versionPrice"/></th>
                                                                                    <th><fmt:message key="movieDetail.button.ticketing"/></th>
                                                                                </tr>
                                                                            </tfoot>
                                                                        </table>
								</div>
				  			</div>

							<div class="clearfix"></div>
						</div>
					</div>
					<div class="review-slider">
                                            <ul id="flexiselDemo1">
                                                <c:forEach items="${allMovies}" var="movie">
                                                <!--<li><a href="<c:out value="${pageContext.request.contextPath}"/>/movie/detail?movieId=<c:out value="${movie.key}"/>"><img src="<c:out value="${movie.value.movieInfo.Poster}"/>"></img></a></li>-->
                                                <li><img src="<c:out value="${movie.value.movieInfo.Poster}"/>" onclick="location.href='<c:out value="${pageContext.request.contextPath}"/>/movie/detail?movieId=<c:out value="${movie.key}"/>'"/></li>
                                                </c:forEach>
                                            </ul>
							
					</div>	
                                </div>
</fmt:bundle>
    <jsp:include page="footer_normal.jsp" />