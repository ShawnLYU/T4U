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
<c:set var="allOrders" value="${requestScope.t4uUserAllOrders}"/>
<!DOCTYPE html>
<html>
    <fmt:bundle basename="${lan}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cinema</title>
        <!-- start plugins -->
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/common.js"></script>
        <script type="text/javascript" src="/T4U/resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/T4U/resources/js/jquery.flexisel.js"></script>	
        <script type="text/javascript" src="/T4U/resources/js/bootstrap-switch.min.js"></script>
        <script src="/T4U/resources/js/moment.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/md5.js" type="text/javascript"></script>
        <script src="/T4U/resources/js/notify.min.js"></script>
        
        <link href="/T4U/resources/css/style_profile.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<!--        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />-->
        <link href="/T4U/resources/css/bootstrap-switch.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
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
        
        $(document).on("click", "#doUpdateProfile", function(event){
            $('#modalForProfile').modal('toggle');
            $("#name").val("${sessionScope.t4uUser.userName}");
            $("#phone").val("${sessionScope.t4uUser.userPhone}");
            $("#email").val("${sessionScope.t4uUser.userEmail}");
            <c:choose>
                <c:when test="${sessionScope.t4uUser.userGender == 'M'}">
                    $("#gender").bootstrapSwitch('state', true);
                   
                </c:when>
                <c:otherwise>
                   $("#gender").bootstrapSwitch('state', false);
                </c:otherwise>
            </c:choose>
        });
        $(document).on("click", "#doUpdatePwd", function(event){
            $('#modalForPassword').modal('toggle');
            
        });
        $(document).on("click", "#updateProfileConfirm", function(event){
            console.log( "GO" ); 
          if($("#name").val()==''){
              $('#modalForProfile').modal('toggle');
                    showErrorMessage("<fmt:message key="notify.message.provideName"/>");

          }
          else if($("#phone").val()==''){
              $('#modalForProfile').modal('toggle');
                    showErrorMessage("<fmt:message key="notify.message.provideNumber"/>");

          }
          else if($("#email").val()==''){
              $('#modalForProfile').modal('toggle');
                    showErrorMessage("<fmt:message key="notify.message.provideEmail"/>");
          }
          else if($('#date1').val()==''){
              $('#modalForProfile').modal('toggle');
                        showErrorMessage("<fmt:message key="notify.message.provideBirthdate"/>");
                        
          }
          else{
            $("input[name='gender']").val($('input[type="checkbox"]').bootstrapSwitch('state'));
                    
            $( "#form1" ).submit();
            $('#modalForProfile').modal('toggle');
          }

        });
        $(document).on("click", "#updatePwdConfirm", function(event){
             console.log( "updatePwdConfirm" ); 
            if(md5($("#oldPwd").val())!="<c:out value="${sessionScope.t4uUser.userPassword}"/>"){
                $('#modalForPassword').modal('toggle');
            showErrorMessage("<fmt:message key="notify.message.provideCorrectPwd"/>");
          }else if($("input[name='newPwd']").val()==''){
            $('#modalForPassword').modal('toggle');
            showErrorMessage("<fmt:message key="notify.message.providePwd"/>");
                        
          }
          else if($("#confirmPwd").val()==''){
              $('#modalForPassword').modal('toggle');
                  showErrorMessage("<fmt:message key="notify.message.provideConPwd"/>");
                  
          }
          else if($("input[name='newPwd']").val()!= $("#confirmPwd").val()){
              $('#modalForPassword').modal('toggle');
                  showErrorMessage("<fmt:message key="notify.message.pwdNotConsistent"/>");
                  
          }else{
            $("input[name='newPwd']").val(md5($("input[name='newPwd']").val()));
                    
            $( "#form2" ).submit();
            $('#modalForPassword').modal('toggle');
          }
        });
        
        function showErrorMessage(msg){
            $.notify(msg, {
                globalPosition: "top left",
                autoHideDelay: 5000});
        }
        </script>
    </head>
    <body>
        <div class="col-sm-8 col-sm-offset-2">
            
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
                            <c:choose>
                                <c:when test="${sessionScope.t4uUser == null}">
                                   <p><fmt:message key="profile.error.e1"/></p>
                                   <a class="b-home" href="/T4U/login.jsp"><fmt:message key="index.label.login" /></a>
                                </c:when>
                                <c:otherwise>
                                   <div class="container">
                                    <div class="row">
                                      <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
                                        <div class="panel panel-info">
                                          <div class="panel-heading">
                                            <h3 class="panel-title"><c:out value="${sessionScope.t4uUser.userName}"/></h3>
                                          </div>
                                          <div class="panel-body">
                                            <div class="row">

                                             <div class=" col-md-12 col-lg-12 "> 
                                                <table class="table table-user-information">
                                                  <tbody>
                                                    <tr>
                                                      <td><fmt:message key="profile.label.account"/></td>
                                                      <td><c:out value="${sessionScope.t4uUser.userAccount}"/></td>
                                                    </tr>
                                                    <tr>
                                                      <td><fmt:message key="profile.label.email"/></td>
                                                      <td><c:out value="${sessionScope.t4uUser.userEmail}"/></td>
                                                    </tr>
                                                    <tr>
                                                      <td><fmt:message key="profile.label.phone"/></td>
                                                      <td><c:out value="${sessionScope.t4uUser.userPhone}"/></td>
                                                    </tr>
                                                     <tr>
                                                      <td><fmt:message key="profile.label.gender"/></td>
                                                      <td><c:out value="${sessionScope.t4uUser.userGender}"/></td>
                                                    </tr>
                                                    <tr>
                                                      <td><fmt:message key="profile.label.birthdate"/></td>
                                                      <td><c:out value="${sessionScope.t4uUser.userBirthdate}"/></td>
                                                    </tr>
                                                    <tr>
                                                      <td><fmt:message key="profile.label.credit"/>:</td>
                                                      <td><c:out value="${sessionScope.t4uUser.userCredit}"/></td>
                                                    </tr>
                                                    <tr>
                                                      <td><fmt:message key="profile.label.userGroup"/>:</td>
                                                      <td><c:out value="${sessionScope.t4uUser.userGroup}"/></td>
                                                    </tr>
                                                  </tbody>
                                                </table>

                                                
                                                <button type="button" class="btn btn-primary" id="doUpdateProfile" ><fmt:message key="profile.label.updateProfile"/></button>
                                                
                                                <button type="button" class="btn btn-primary" id="doUpdatePwd"><fmt:message key="profile.label.changePassword"/></button>
                                              </div>
                                            </div>
                                          </div>

                                        </div>
                                      </div>
                                    </div>
                                    
                                    <div class="row">
                                      <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
                                        <div class="panel panel-info">
                                          <div class="panel-heading">
                                            <h3 class="panel-title">Sheena Kristin A.Eschor</h3>
                                          </div>
                                          <div class="panel-body">
                                            <div class="row">

                                             <div class=" col-md-9 col-lg-9 "> 
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th><fmt:message key="profile.label.date"/></th>
                                                            <th><fmt:message key="profile.label.movie"/></th>
                                                            <th><fmt:message key="profile.label.cinema"/></th>
                                                            <th><fmt:message key="profile.label.status"/></th>
                                                            <th><fmt:message key="profile.label.action"/></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach items="${allOrders}" var="order">
                                                        <tr>
                                                            <td>+</td>
                                                            <td><c:out value="${order.key}"/></td>
                                                            <td><c:out value="${order.value.schedule.version.movie.movieName}"/></td>
                                                            <td><c:out value="${order.value.schedule.house.cinema.cinemaName}"/></td>
                                                            <td>
                                                            <c:choose>
                                                                <c:when test="${(order.value.orderStatus==1)}">
                                                                    <fmt:message key="profile.label.statusPaid"/>
                                                                </c:when>
                                                                <c:when test="${(order.value.orderStatus==2)}">
                                                                    <fmt:message key="profile.label.statusPending"/>
                                                                </c:when>
                                                                <c:when test="${(order.value.orderStatus==3)}">
                                                                    <fmt:message key="profile.label.statusRefunded"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:message key="profile.label.statusUnmanaged"/>
                                                                </c:otherwise>
                                                            </c:choose>    
                                                            </td>
                                                            <td>
                                                            <c:choose>
                                                                <c:when test="${(order.value.orderStatus==1) && (order.value.orderIsRefundable)}">
                                                                    <fmt:message key="profile.label.applyRefund"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:message key="profile.label.noAction"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>

                                                <a href="#" class="btn btn-primary">My Sales Performance</a>
                                                <a href="#" class="btn btn-primary">Team Sales Performance</a>
                                              </div>
                                            </div>
                                          </div>

                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                </c:otherwise>
                            </c:choose>
                        </div>		
                    </div>
                </div>
                 <!-- Modal for update profile -->
                <div class="modal fade" id="modalForProfile" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><fmt:message key="profile.label.updateProfile"/></h4>
                      </div>
                      <div class="modal-body">
                        <form id="form1" action="/T4U/user/update.do" method="POST" role="form">
                            <input name='action' type='hidden' value='profile' />
                            <div class="form-group">
                              <label for="name"><fmt:message key="register.label.name"/><label>*</label></label>
                              <input type="text" class="form-control" id="name" name="name">
                            </div>
                            <div class="form-group">
                              <label for="phone"><fmt:message key="register.label.phone"/><label>*</label></label>
                              <input type="text" class="form-control" id="phone" name="phone">
                            </div>
                            <div class="form-group">
                              <label for="account"><fmt:message key="register.label.account"/></label>
                              <input type="text" class="form-control " readonly id="account" name="account" value="${sessionScope.t4uUser.userAccount}">
                            </div>
                            <div class="form-group">
                              <label for="email"><fmt:message key="register.label.email"/><label>*</label></label>
                              <input type="text" class="form-control" id="email" name="email"> 
                            </div>
                            <div class="form-group">
                                <label><fmt:message key="register.label.birthdate"  /><label>*</label></label>
                                <div class="input-group" id="datetimepicker1">
                                    <input type='text' name="birthdate" class="form-control" id="date1"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><fmt:message key="register.label.gender"/><label>*</label></label>
                                <div class="checkbox">
                                    <input type="checkbox" name="gender" id="gender"/>
                                </div>
                            </div>
                            
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button id="updateProfileConfirm" type="button" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><fmt:message key="profile.label.cancel"/></button>
                      </div>
                    </div>

                  </div>
                </div>


                <!-- Modal for update password -->
                <div class="modal fade" id="modalForPassword" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><fmt:message key="profile.label.changePassword"/></h4>
                      </div>
                      <div class="modal-body">
                        
                        <form id="form2" action="/T4U/user/update.do" method="POST" role="form">
                            <input name='action' type='hidden' value='pwd' />
                            <div class="form-group">
                              <label for="account2"><fmt:message key="register.label.account"/></label>
                              <input type="text" class="form-control " readonly id="account2" name="account2" value="${sessionScope.t4uUser.userAccount}">
                            </div>
                            <div class="form-group">
                              <label for="oldPwd"><fmt:message key="profile.label.oldPwd"/></label>
                              <input type="password" class="form-control " id="oldPwd">
                            </div>
                            <div class="form-group">
                              <label for="newPwd"><fmt:message key="profile.label.newPwd"/></label>
                              <input type="password" class="form-control " id="newPwd" name="newPwd">
                            </div>
                            <div class="form-group">
                              <label for="confirmPwd"><fmt:message key="profile.label.confirmPwd"/></label>
                              <input type="password" class="form-control " id="confirmPwd">
                            </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" id="updatePwdConfirm" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><fmt:message key="profile.label.cancel"/></button>
                      </div>
                    </div>

                  </div>
                </div>                   
                
                
                </fmt:bundle>
                <jsp:include page="footer_normal.jsp" />
                