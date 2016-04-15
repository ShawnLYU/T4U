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
        <script src="resources/js/jquery-1.11.1.min.js"></script>
        <script src="resources/js/common.js"></script>
        <script type="text/javascript" src="resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="resources/js/jquery.flexisel.js"></script>	
        
        <link href="resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="resources/css/style_index.css" rel="stylesheet" type="text/css" media="all" />
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
            });
        </script>
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
                                                    <a href="index.html"><img src="resources/images/logo.png" alt="" /></a>
                                                    <p>Movie Theater</p>
                                                </div>
                                                <div class="search v-search">
                                                    <div  class="btn-group" role="group">
                                                    <button type="button" class="btn btn-default col-sm-4" onclick="setLocaleEN();">En</button>
                                                    <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleCN();">简</button>
                                                    <button type="button" class="btn btn-default col-sm-4 col-sm-offset-4" onclick="setLocaleHK();">繁</button>
                                                </div>  
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
						<div class="reviews-section">
							<h3 class="head">Movie Reviews</h3>
							<div class="col-md-12 reviews-grids">
								<div class="review">
                                                                    <div class="movie-pic">
                                                                            <a href="single.html"><img src="resources/images/r4.jpg" alt="" /></a>
                                                                    </div>
                                                                    <div class="review-info">
                                                                        <a class="span" href="single.html">Lorem  <i>Movie Review</i></a>
                                                                        <p class="dirctr"><a href="">Reagan Gavin Rasquinha, </a>TNN, Mar 12, 2015, 12.47PM IST</p>
                                                                        <p class="ratingview">Critic's Rating:</p>
                                                                        <div class="rating">
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                        </div>
                                                                        <p class="ratingview">
                                                                        &nbsp;3.5/5  
                                                                        </p>
                                                                        <div class="clearfix"></div>
                                                                        <p class="ratingview c-rating">Avg Readers' Rating:</p>
                                                                        <div class="rating c-rating">
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                            <span>☆</span>
                                                                        </div> 	
                                                                        <p class="ratingview c-rating">								
                                                                        &nbsp; 3.3/5</p>
                                                                        <div class="clearfix"></div>
                                                                        <div class="yrw">
                                                                            <div class="dropdown-button">           			
                                                                                <select class="dropdown" tabindex="9" data-settings='{"wrapperClass":"flat"}'>
                                                                                <option value="0">Your rating</option>	
                                                                                <option value="1">1.Poor</option>
                                                                                <option value="2">1.5(Below average)</option>
                                                                                <option value="3">2.Average</option>
                                                                                <option value="4">2.5(Above average)</option>
                                                                                <option value="5">3.Watchable</option>
                                                                                <option value="6">3.5(Good)</option>
                                                                                <option value="7">4.5(Very good)</option>
                                                                                <option value="8">5.Outstanding</option>
                                                                              </select>
                                                                            </div>
                                                                            <div class="rtm text-center">
                                                                                <a href="#">REVIEW THIS MOVIE</a>
                                                                            </div>
                                                                            <div class="wt text-center">
                                                                                <a href="#">WATCH THIS TRAILER</a>
                                                                            </div>
                                                                            <div class="clearfix"></div>
                                                                        </div>
                                                                        <p class="info">CAST:&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Will Smith, Margot Robbie, Adrian Martinez, Rodrigo Santoro, BD Wong, Robert Taylor</p>
                                                                        <p class="info">DIRECTION: &nbsp;&nbsp;&nbsp;&nbsp;Glenn Ficarra, John Requa</p>
                                                                        <p class="info">GENRE:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Crime</p>
                                                                        <p class="info">DURATION:&nbsp;&nbsp;&nbsp; &nbsp; 1 hour 45 minutes</p>
                                                                    </div>
                                                                    <div class="clearfix"></div>
								</div>
								<div class="single">
									<h3>Lorem Ipsum IS A TENSE, TAUT, COMPELLING THRILLER</h3>
									<p>STORY:<i> Meera and Arjun drive down Lorem Ipsum - can they survive a highway from hell?</i></p>
								</div>
								<div class="best-review">
									<h4>Best Reader's Review</h4>
									<p>Excellent Movie and great performance by Lorem, one of the finest thriller of recent  like Aldus PageMaker including versions of Lorem Ipsum.</p>
									<p><span>Neeraj Upadhyay (Noida)</span> 16/03/2015 at 12:14 PM</p>
								</div>
								<div class="story-review">
									<h4>REVIEW:</h4>
									<p>So,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
								</div>
									<!-- comments-section-starts -->
							    <div class="comments-section">
                                                            <div class="comments-section-head">
                                                                            <div class="comments-section-head-text">
                                                                                    <h3>25 Comments</h3>
                                                                            </div>
                                                                            <div class="clearfix"></div>
                                                            </div>
                                                                <div class="comments-section-grids">
                                                                    <div class="comments-section-grid">
                                                                        <div class="col-md-2 comments-section-grid-image">
                                                                                <img src="resources/images/eye-brow.jpg" class="img-responsive" alt="" />
                                                                        </div>
                                                                        <div class="col-md-10 comments-section-grid-text">
                                                                            <h4><a href="#">MARWA ELGENDY</a></h4>
                                                                            <label>5/4/2014 at 22:00   </label>
                                                                            <p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound but because those who do not know how to pursue pleasure rationally encounter consequences.</p>
                                                                            <span><a href="#">Reply</a></span>
                                                                            <i class="rply-arrow"></i>
                                                                        </div>
                                                                        <div class="clearfix"></div>
                                                                    </div>
                                                                    <div class="comments-section-grid comments-section-middle-grid">
                                                                        <div class="col-md-2 comments-section-grid-image">
                                                                            <img src="resources/images/beauty.jpg" class="img-responsive" alt="" />
                                                                        </div>
                                                                        <div class="col-md-10 comments-section-grid-text">
                                                                            <h4><a href="#">MARWA ELGENDY</a></h4>
                                                                            <label>5/4/2014 at 22:00   </label>
                                                                            <p>But I must explain to you how all this idea denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound but because those who do not know how to pursue pleasure rationally encounter consequences.</p>
                                                                            <span><a href="#">Reply</a></span>
                                                                            <i class="rply-arrow"></i>
                                                                        </div>
                                                                        <div class="clearfix"></div>
                                                                    </div>
                                                                    <div class="comments-section-grid">
                                                                        <div class="col-md-2 comments-section-grid-image">
                                                                            <img src="resources/images/stylish.jpg" class="img-responsive" alt="" />
                                                                        </div>
                                                                        <div class="col-md-10 comments-section-grid-text">
                                                                            <h4><a href="#">MARWA ELGENDY</a></h4>
                                                                            <label>5/4/2014 at 22:00   </label>
                                                                            <p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound but because those who do not know how to pursue pleasure rationally encounter consequences.</p>
                                                                            <span><a href="#">Reply</a></span>
                                                                            <i class="rply-arrow"></i>
                                                                        </div>
                                                                        <div class="clearfix"></div>
                                                                    </div>
                                                                </div>
							    </div>
								<!-- comments-section-ends -->
                                                            <div class="reply-section">
                                                                <div class="reply-section-head">
                                                                    <div class="reply-section-head-text">
                                                                        <h3>Leave Reply</h3>
                                                                     </div>
                                                                </div> 
                                                                <div class="blog-form">
                                                                    <form>
                                                                        <input type="text" class="text" value="Enter Name" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Enter Name';}">
                                                                        <input type="text" class="text" value="Enter Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Enter Email';}">
                                                                        <input type="text" class="text" value="Subject" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Subject';}">
                                                                        <textarea></textarea>
                                                                        <input type="button" value="SUBMIT COMMENT">
                                                                    </form>
                                                                 </div>
                                                            </div>
				  			</div>

							<div class="clearfix"></div>
						</div>
					</div>
					<div class="review-slider">
                                            <ul id="flexiselDemo1">
                                                <li><img src="resources/images/r1.jpg" alt=""/></li>
                                                <li><img src="resources/images/r2.jpg" alt=""/></li>
                                                <li><img src="resources/images/r3.jpg" alt=""/></li>
                                                <li><img src="resources/images/r4.jpg" alt=""/></li>
                                                <li><img src="resources/images/r5.jpg" alt=""/></li>
                                                <li><img src="resources/images/r6.jpg" alt=""/></li>
                                            </ul>
							
					</div>	
                                </div>
</fmt:bundle>
    <jsp:include page="footer_normal.jsp" />