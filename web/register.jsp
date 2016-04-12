<%-- 
    Document   : register
    Created on : Apr 11, 2016, 1:25:21 PM
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
<!DOCTYPE HTML>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cinema</title>
        <!-- start plugins -->
        <script src="resources/js/jquery-1.11.1.min.js"></script>
        <script src="resources/js/jquery.validate.min.js"></script>
        <script src="resources/js/additional-methods.js"></script>
        <script src="resources/js/notify.min.js"></script>
        <script src="resources/js/common.js"></script>
        <script type="text/javascript" src="resources/js/bootstrap-switch.min.js"></script>
        <script type="text/javascript" src="resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script src="resources/js/moment.js" type="text/javascript"></script>
        <script src="resources/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>

        <link href="resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="resources/css/style_register.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />
        <link href="resources/css/bootstrap-switch.min.css" rel='stylesheet' type='text/css' />
        <link href="resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    </head>
    
    <body> 
        <fmt:bundle basename="${lan}">
        <div class="container">
            <div class="container_wrap">
                <div class="header_top">
                    <div class="col-sm-3 logo">
                        <a href="index.html"><img src="resources/images/logo.png" alt=""/></a>
                    </div>
                    <div class="col-sm-3 col-sm-offset-6 nav">
                        <div  class="btn-group" role="group">
                            <button type="button" class="btn btn-default" onclick="setLocaleEN();">En</button>
                            <button type="button" class="btn btn-default" onclick="setLocaleCN();">简</button>
                            <button type="button" class="btn btn-default" onclick="setLocaleHK();">繁</button>
                        </div>
                    </div>
                    <div class="col-sm-3 header_right">
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="content">
                    <div class="register">
                        <form id="form1" action="/user/register" method="POST"> 
                            <div class="register-top-grid">
                                <h3><fmt:message key="register.label.titlePersonal"  /></h3>
                                <div>
                                    <span><fmt:message key="register.label.firstName"  /><label>*</label></span>
                                    <input type="text" name="firstName"> 
                                </div>
                                <div>
                                    <span><fmt:message key="register.label.lastName"  /><label>*</label></span>
                                    <input type="text" name="lastName"> 
                                </div>
                                <div>
                                    <span><fmt:message key="register.label.phone"  /><label>*</label></span>
                                    <input type="text" name="phone"> 
                                 </div>
                                 <div>
                                    <span><fmt:message key="register.label.gender"  /><label>*</label></span>
                                    
                                    <input type="checkbox" checked />
                                 </div>
                                
                                <div class="clearfix"> </div>
                                <a class="news-letter" href="#">
                                <!--
                                      <label class="checkbox"><input type="checkbox" name="checkbox" checked=""><i> </i>Sign Up for Newsletter</label>
                                      -->
                                </a>
                             </div>
                             <div class="col-xs-12" style="padding-left:0px;">
                                <div class="form-group" >
                                    <span><fmt:message key="register.label.birthdate"  /><label>*</label></span>
                                    <div class="input-group" id="datetimepicker1">
                                        <input type='text' class="form-control" id="date1"/>
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar">
                                            </span>
                                        </span>
                                    </div>
                                </div>
                             </div>
                            <div class="register-bottom-grid">
                                <h3><fmt:message key="register.label.titleLogin"  /></h3>
                                    <div>
                                        <span><fmt:message key="register.label.account"  /><label>*</label></span>
                                        <input type="text" name="userAccount"> 
                                    </div>
                                    <div>
                                        <span><fmt:message key="register.label.email"  /><label>*</label></span>
                                        <input type="text" name="email"> 
                                    </div>
                                    <div>
                                        <span><fmt:message key="register.label.pwd"  /><label>*</label></span>
                                        <input type="text" name="password1">
                                    </div>
                                    <div>
                                        <span><fmt:message key="register.label.confirmPwd"  /><label>*</label></span>
                                        <input type="text" name="password2">
                                    </div>
                                    <div class="clearfix"> </div>
                            </div>
                            <input type="submit" value="<fmt:message key="login.label.submit"  />">
                            <div class="clearfix"> </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
        $(document).ready(function(){
            $('input[type="checkbox"]').bootstrapSwitch('onText',"M",'M');
            $('input[type="checkbox"]').bootstrapSwitch('offText',"F",'F');
            $('input[type="checkbox"]').bootstrapSwitch('offColor',"warning",'warning');
            $('#datetimepicker1').datetimepicker({
                viewMode: 'years',
                format: 'DD/MM/YYYY'
             });
            //$('#date1').val()
        });
        $('input[type="checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
          console.log(this); // DOM element
          console.log(event); // jQuery event
          console.log(state); // true | false
          //$('input[type="checkbox"]').bootstrapSwitch('state')


        });
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
                if($("input[name='phone']")='').val()){
                        showErrorMessage("You must provide your phone number here");
                        return false;
                }
                if($('#date1').val()=''){
                        showErrorMessage("You must provide your birth date here");
                        return false;
                }
                if($("input[name='account']").val()==''){
                        showErrorMessage("You must provide your account here");
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
        </fmt:bundle>
        <jsp:include page="footer.jsp" />
