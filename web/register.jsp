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
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/notify.min.js"></script>
        <script src="/T4U/resources/js/common.js"></script>
        <script type="text/javascript" src="/T4U/resources/js/bootstrap-switch.min.js"></script>
        <script type="text/javascript" src="/T4U/resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script src="/T4U/resources/js/moment.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/md5.js" type="text/javascript"></script>

        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_register.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
        <link href="/T4U/resources/css/common.css" rel="stylesheet" type='text/css' />
        <link href="/T4U/resources/css/bootstrap-switch.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    </head>
    
    <body> 
        <fmt:bundle basename="${lan}">
        <div class="container">
            <div class="container_wrap">
                <div class="header_top">
                    <div class="col-sm-3 logo">
                        <a href="${pageContext.request.contextPath}/index"><img src="/T4U/resources/images/logo.png" alt=""/></a>
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
                        <form id="form1" action="/T4U/user/register" method="POST"> 
                            <div class="register-top-grid">
                                <h3><fmt:message key="register.label.titlePersonal"  /></h3>
                                <div>
                                    <span><fmt:message key="register.label.name"  /><label>*</label></span>
                                    <input type="text" name="name"> 
                                </div>
                                <div>
                                    <span><fmt:message key="register.label.phone"  /><label>*</label></span>
                                    <input type="text" name="phone"> 
                                 </div>
                                 <div>
                                    <span><fmt:message key="register.label.gender"  /><label>*</label></span>
                                    
                                    <input type="checkbox" name="gender" checked />
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
                                        <input type='text' name="birthdate" class="form-control" id="date1"/>
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
                                        <input type="password" name="password1">
                                    </div>
                                    <div>
                                        <span><fmt:message key="register.label.confirmPwd"  /><label>*</label></span>
                                        <input type="password" name="password2">
                                    </div>
                                    <div class="clearfix"> </div>
                            </div>
                            <div class="register-bottom-grid">
                                    <div>
                                        <input type="button" name="ign" class="btn btn-default" value="<fmt:message key="register.label.submit"  />">
                                    </div>
                                    <div>
                                        <input type="button" id="login" class="btn btn-default" value="<fmt:message key="login.label.submit"  />">
                                    </div>
                                    
                                    <div class="clearfix"> </div>
                            </div>
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
         $('#login').click(function(){
           window.location.href = '/T4U/login.jsp'; //relative to domain
       }) ;
            $('input[type="button"]').click(function() {
                if($("input[name='name']").val()==''){
                        showErrorMessage("<fmt:message key="notify.message.provideName"/>");
                        
                }
                else if($("input[name='phone']").val()==''){
                        showErrorMessage("<fmt:message key="notify.message.provideNumber"/>");
                        
                }
                else if($('#date1').val()==''){
                        showErrorMessage("<fmt:message key="notify.message.provideBirthdate"/>");
                        
                }
                else if($("input[name='account']").val()==''){
                        showErrorMessage("<fmt:message key="notify.message.provideAccount"/>");
                        
                }
                else if($("input[name='password1']").val()==''){
                        showErrorMessage("<fmt:message key="notify.message.providePwd"/>");
                        
                }
                else if($("input[name='password2']").val()==''){
                        showErrorMessage("<fmt:message key="notify.message.provideConPwd"/>");
                        
                }
                else if($("input[name='password1']").val()!= $("input[name='password2']").val()){
                        showErrorMessage("<fmt:message key="notify.message.pwdNotConsistent"/>");
                        
                }
                else if($("input[name='email']").val()==''){
                        showErrorMessage("<fmt:message key="notify.message.provideEmail"/>");
                        
                }
                else{
//                    var input = $("<input>")
//                                    .attr("type", "hidden")
//                                    .attr("name", "gender").val($('input[type="checkbox"]').bootstrapSwitch('state'));
//                    $('#form1').append($(input));
                    $("input[name='gender']").val($('input[type="checkbox"]').bootstrapSwitch('state'));
                    $("input[name='password1']").val(md5($("input[name='password1']").val()));
                    
                    $( "#form1" ).submit();
                }
                
                
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
