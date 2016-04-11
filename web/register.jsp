<%-- 
    Document   : register
    Created on : Apr 11, 2016, 1:25:21 PM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=gb2312" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" />
<fmt:setBundle basename="com.ss.i18n.T4uUI" />
<!DOCTYPE HTML>
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
<title>Cinema</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- start plugins -->
<script src="resources/js/jquery-1.11.1.min.js"></script>
<script src="resources/js/jquery.validate.min.js"></script>
<script src="resources/js/additional-methods.min.js"></script>
<script src="resources/js/notify.min.js"></script>
<script src="resources/js/common.js"></script>


<link href="resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<link href="resources/css/style_register.css" rel="stylesheet" type="text/css" media="all" />
<link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<link href="resources/css/common.css" rel="stylesheet" type='text/css' />
</head>
<body>

<div class="container">
	<div class="container_wrap">
		<div class="header_top">
		    <div class="col-sm-3 logo"><a href="index.html"><img src="resources/images/logo.png" alt=""/></a></div>
		    <div class="col-sm-3 col-sm-offset-6 nav">
                        <div  class="btn-group" role="group" aria-label="...">
                            <button type="button" class="btn btn-default" onclick="setLocaleEN();">En</button>
                            <button type="button" class="btn btn-default" onclick="setLocaleCN();">简</button>
                            <button type="button" class="btn btn-default" onclick="setLocaleHK();">繁</button>
                        </div> 
                        <c:set var="todayValue" value="<%=new Date() %>"/>
                        <fmt:setLocale value="zh_CN"/> <fmt:formatDate value="${todayValue}"/>
		    <!--
			  <ul>
				 <li> <span class="simptip-position-bottom simptip-movable" data-tooltip="comic"><a href="movie.html"> </a></span></li>
				 <li><span class="simptip-position-bottom simptip-movable" data-tooltip="movie"><a href="movie.html"> </a> </span></li>
				 <li><span class="simptip-position-bottom simptip-movable" data-tooltip="video"><a href="movie.html"> </a></span></li>
				 <li><span class="simptip-position-bottom simptip-movable" data-tooltip="game"><a href="movie.html"> </a></span></li>
				 <li><span class="simptip-position-bottom simptip-movable" data-tooltip="tv"><a href="movie.html"> </a></span></li>
				 <li><span class="simptip-position-bottom simptip-movable" data-tooltip="more"><a href="movie.html"> </a></span></li>
			 </ul>
			-->
			</div>
			<div class="col-sm-3 header_right">
			<!--
			   <ul class="header_right_box">
				 <li><img src="images/p1.png" alt=""/></li>
				 <li><p><a href="login.html">Carol Varois</a></p></li>
				 <li class="last"><i class="edit"> </i></li>
				 <div class="clearfix"> </div>
			   </ul>
			-->
			</div>
			<div class="clearfix"> </div>
	      </div>
	      <div class="content">
      	     <div class="register">
		  	  <form id="form1" method="POST"> 
				 	<div class="register-top-grid">
						<h3><fmt:message key="register.label.titlePersonal"/></h3> <div>
							<span><fmt:message key="register.label.firstName"/><label>*</label></span>
							<input type="text" name="firstName"> 
						 </div>
						 <div>
							<span><fmt:message key="register.label.lastName"/><label>*</label></span>
							<input type="text" name="lastName"> 
						 </div>
						 <div>
							 <span><fmt:message key="register.label.email"/><label>*</label></span>
							 <input type="text" name="email"> 
						 </div>
						 <div class="clearfix"> </div>
						   <a class="news-letter" href="#">
						   <!--
							 <label class="checkbox"><input type="checkbox" name="checkbox" checked=""><i> </i>Sign Up for Newsletter</label>
							 -->
						   </a>
					 </div>
				     <div class="register-bottom-grid">
						    <h3><fmt:message key="register.label.titleLogin"/></h3>
							 <div>
								<span><fmt:message key="register.label.pwd"/><label>*</label></span>
								<input type="text" name="password1">
							 </div>
							 <div>
								<span><fmt:message key="register.label.confirmPwd"/><label>*</label></span>
								<input type="text" name="password2">
							 </div>
							 <div class="clearfix"> </div>
					 </div>
					   <input type="submit" value="submit">
					   <div class="clearfix"> </div>
				   </form>
				</div>
		   </div>
           </div>
    </div>
</div>
<script type="text/javascript">
	jQuery.validator.setDefaults({
	  debug: true,
	  success: "valid"
	});
	$( "#form1" ).validate({
	  rules: {
	    email: {
	      required: true,
	      email: true
	    }
	  }
	});
    $('#form1').submit(function() {
        if($("input[name='firstName']").val()==''){
        	showErrorMessage("You must provide your first name here");
        	return false;
        }
        if($("input[name='lastName']").val()==''){
        	showErrorMessage("You must provide your last name here");
        	return false;
        }
        if($("input[name='password1']").val()==''){
        	showErrorMessage("You must provide your password");
        	return false;
        }
        if($("input[name='password2']").val()==''){
        	showErrorMessage("You need to confirm your password");
        	return false;
        }
        if($("input[name='password1']").val()!= $("input[name='password2']").val()){
        	showErrorMessage("Passwords are not consistent");
        	return false;
        }

        return true; // return false to cancel form action
    });
    function showErrorMessage(msg){
	$.notify(msg, {
			globalPosition: "top left",
			autoHideDelay: 5000});
}
</script>
<div class="container"> 
 
</div>	
<jsp:include page="footer.jsp" />
