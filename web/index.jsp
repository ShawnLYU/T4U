<%-- 
    Document   : index
    Created on : Apr 4, 2016, 10:15:05 AM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<c:set var="allMovies" value="${applicationScope.t4uAllMovies}"/>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Disclaimer:This web site exists to fulfill the coursework requirement of CS4280.Do not use your real personal data as input.">
        <title>Cinema</title>
        <!-- start plugins -->
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/common.js"></script>
        <script type="text/javascript" src="/T4U/resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/T4U/resources/js/jquery.flexisel.js"></script>	
        <script type="text/javascript" src="/T4U/resources/js/jquery.scrollTo.min.js"></script>	
        
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_index.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <script type="text/javascript">
            $(document).ready(function(){
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
                                visibleItems: 2
                        }, 
                        landscape: { 
                                changePoint:640,
                                visibleItems: 3
                        },
                        tablet: { 
                                changePoint:768,
                                visibleItems: 4
                        }
                }
            });
            $("#flexiselDemo2").flexisel({
                  visibleItems: 4,
                  animationSpeed: 1000,
                  autoPlay: true,
                  autoPlaySpeed: 3000,    		
                  pauseOnHover: false,
                  enableResponsiveBreakpoints: true,
                  responsiveBreakpoints: { 
                          portrait: { 
                                  changePoint:480,
                                  visibleItems: 2
                          }, 
                          landscape: { 
                                  changePoint:640,
                                  visibleItems: 3
                          },
                          tablet: { 
                                  changePoint:768,
                                  visibleItems: 3
                          }
                  }
              });
              
              
              
          });
          function showTrailer(address){
//                  $("iframe").attr("src", "https://www.youtube.com/embed/"+address); 
//                  var iFrame = $('iframe');
//                    iFrame.load("https://www.youtube.com/embed/"+address);
                    document.getElementById('myFrame').src = "https://www.youtube.com/embed/"+address;
              }
            function showPosterLandscape(url) {
                $('.header').css('background-image', 'url(/T4U/resources/images/header-bg.png), url(' + url + ')');
            }
            function showIntroduction(movieId, movieName, movieClass, movieGenre) {
                $('.header-info h1').html(movieName);
                $('.header-info .age a').html(movieClass);
                $('.header-info .review span').html(movieGenre);
                $('.header-info .book').attr("href", "<c:out value="${pageContext.request.contextPath}"/>/movie/detail?movieId=" + movieId);
            }
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
                <div class="header">
                    <div class="top-header">
                        <div class="logo">
                            <a href="${pageContext.request.contextPath}/index"><img src="resources/images/logo.png" alt="" /></a>
                            <p>Movie Theater</p>
                        </div>
                        <div class="search" style="width:40%">
                            <div  class="btn-group col-sm-6" role="group">
                                <button type="button" class="btn btn-default col-sm-4" onclick="setLocaleEN();">En</button>
                                <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleCN();">简</button>
                                <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleHK();">繁</button>
                                
                            </div>  
                            <%@include file="userDropDownMenu.jsp" %>
                        </div>
                        <div class="clearfix">
                            
                        </div>
                    </div>
                    <div class="header-info">
                        <c:forEach items="${allMovies}" var="movie">
                            <c:if test="${empty firstMovie}">
                                <c:set var="firstMovie" scope="request" value="${movie}"/>
                            </c:if>
                        </c:forEach>
                        <h1>${firstMovie.value.movieName}</h1>
                        <p class="age"><fmt:message key="movieDetail.label.class"/>&nbsp;&nbsp;&nbsp;&nbsp;<a>${firstMovie.value.movieInfo.Class}</a></p>
                        <p class="review"><fmt:message key="movieDetail.label.genre"/>&nbsp;&nbsp;&nbsp;&nbsp;<span>${firstMovie.value.movieInfo.Genre}</span></p>
                        <!-- <p class="review reviewgo">Genre	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp; Animation, Action, Comedy</p>
                        <p class="review">Release &nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; 7 November 2014</p>
                        <p class="special">The special bond that develops between plus-sized inflatable robot Baymax, and prodigy Hiro Hamada, who team up with a group of friends to form a band of high-tech heroes.</p>-->
                        <a class="video scrollLink" href="#myFrame" ><i class="video1"></i><fmt:message key="index.label.watchTrailer"/></a>
                        <a class="book" href='<c:out value="${pageContext.request.contextPath}"/>/movie/detail?movieId=<c:out value="${firstMovie.key}"/>'><i class="book1"></i><fmt:message key="index.label.bookTicket"/></a>
                    </div>
                </div>
                <div class="review-slider">
                    <ul id="flexiselDemo1">
                        <c:forEach items="${allMovies}" var="movie">
                            <c:set var="singleQuote" value="'" />
                            <c:set var="escapedSingleQuote" value="\'" />
                            <c:set var="movieName" value="${movie.value.movieName}" />
                            <c:set var="movieClass" value="${movie.value.movieInfo.Class}" />
                            <c:set var="movieGenre" value="${movie.value.movieInfo.Genre}" />
                            <li><img class="trailerToBePlayed" src="<c:out value="${movie.value.movieInfo.Poster}"/>" onclick="showTrailer('<c:out value="${movie.value.movieInfo.Trailer}"/>');showPosterLandscape('<c:out value="${movie.value.movieInfo.PosterLandscape}" />');showIntroduction(${movie.key}, '<c:out value="${fn:replace(movieName, singleQuote, escapedSingleQuote)}"/>', '<c:out value="${fn:replace(movieClass, singleQuote, escapedSingleQuote)}"/>', '<c:out value="${fn:replace(movieGenre, singleQuote, escapedSingleQuote)}"/>');"></img></li>
                        </c:forEach>
                    </ul>


                </div>
                <div class="video">
                    <iframe id="myFrame" src="https://www.youtube.com/embed/${firstMovie.value.movieInfo.Trailer}" frameborder="0" allowfullscreen></iframe>
                </div>
                <div class="news">
                    <div class="col-md-6 news-left-grid">
                        <h3><fmt:message key="index.label.ad1"/></h3>
                        <h2><fmt:message key="index.label.ad2"/></h2>
                        <h4><fmt:message key="index.label.ad3"/></h4>
                        <a href="#flexiselDemo2"><i class="book"></i><fmt:message key="index.label.bookTicket"/></a>
                        <p><fmt:message key="index.label.ad4"/> <strong>10%</strong> <fmt:message key="index.label.ad5"/></p>
                    </div>
                    <div class="col-md-6 news-right-grid">
                        <h3>News</h3>
                        <div class="news-grid">
                            <h5>《優獸》全球勁收24億</h5>
                            <label>Mar 14 2016</label>
                            <p>迪士尼動畫電影《優獸大都會》（Zootopia）在美國大收旺場，踏入第二周仍高踞北美票房榜冠軍。該片在內地開畫也同樣錄得票房佳績，截至昨日已累積達7億人民幣，比《功夫熊貓3》（Kung Fu Panda3）成績更加理想。目前《優獸大都會》的全球票房已高達3.11億美元（約24.3億港元），相信各地陸續上映之後，票房仍會繼續飆升，而香港則定於下周四上映。（《蘋果日報》）</p>
                        </div>
                        <div class="news-grid">
                            <h5>Captain America goes rogue in Civil War, new Avengers movie</h5>
                            <label>Mar 9 2016</label>
                            <p>Captain America might be taken off Iron Man’s Christmas list this year. The two Avengers find themselves on opposite sides of an ideological debate about government oversight, and the rest of the Avengers are forced to take sides and face off in Marvel Studios’ soon-to-be blockbuster Captain America: Civil War. (SCMP)</p>
                        </div>
                    </div>
                    <div class="clearfix">

                    </div>
                </div>
                <div class="more-reviews">
                    <ul id="flexiselDemo2">
                        <c:forEach items="${allMovies}" var="movie">
                        <!--<li><a href="<c:out value="${pageContext.request.contextPath}"/>/movie/detail?movieId=<c:out value="${movie.key}"/>"><img src="<c:out value="${movie.value.movieInfo.Poster}"/>"></img></a></li>-->
                        <li><img src="<c:out value="${movie.value.movieInfo.Poster}"/>" onclick="location.href='<c:out value="${pageContext.request.contextPath}"/>/movie/detail?movieId=<c:out value="${movie.key}"/>'"/></li>
                        </c:forEach>
                    </ul>
                </div>	
            </div>
                    
                    <script>
                        $(document).ready(function(){
                            $(".scrollLink").click(function(e) {

                                $.scrollTo($(this).attr("href"));    
                                e.preventDefault();

                            });
                            
                        });
                    </script>
    </fmt:bundle>
    <jsp:include page="footer_normal.jsp" />
