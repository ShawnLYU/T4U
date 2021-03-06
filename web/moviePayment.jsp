<%-- 
    Document   : error
    Created on : Apr 11, 2016, 8:41:10 PM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="lan" value="com.ss.i18n.T4uUI" scope="application" />
<fmt:setBundle basename="com.ss.i18n" />
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
    <fmt:bundle basename="${lan}">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Disclaimer:This web site exists to fulfill the coursework requirement of CS4280.Do not use your real personal data as input.">
        <title>Cinema</title>
        <!-- start plugins -->
        <script src="/T4U/resources/js/jquery-1.11.1.min.js"></script>
        <script src="/T4U/resources/js/common.js"></script>
        <script type="text/javascript" src="/T4U/resources/bootstrap-3.3.6/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/T4U/resources/js/jquery.flexisel.js"></script>	
        <script src="/T4U/resources/js/notify.min.js"></script>
        <script src="/T4U/resources/js/jquery.bootstrap-touchspin.js"></script>

        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />
        <link href="resources/css/jquery.bootstrap-touchspin.css" rel="stylesheet" type='text/css' />
    </head>
    <body>
        
        <div class="col-sm-6 col-sm-offset-3 toppad" style="padding-top: 4em;">
        <div class="panel panel-info">
      <div class="panel-heading">
        <h3 class="panel-title">${requestScope.t4uScheduleToBePaid.version.movie.movieName}</h3>
      </div>
      <div class="panel-body">
        <div class="row">

         <div class=" col-md-8 col-lg-8 col-md-offset-2 col-lg-offset-2 table-responsive"> 
            <table class="table table-user-information">
              <tbody>
                <tr>
                  <td><fmt:message key="payment.form.version"/>:</td>
                  <td>${requestScope.t4uScheduleToBePaid.version.versionName}</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.time"/>:</td>
                  <td>${requestScope.t4uScheduleToBePaid.scheduleTimeslot   }</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.houseName"/>:</td>
                  <td>${requestScope.t4uScheduleToBePaid.house.houseName}</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.cinemaName"/>:</td>
                  <td>${requestScope.t4uScheduleToBePaid.house.cinema.cinemaName}</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.cinemaLocation"/>:</td>
                  <td>${requestScope.t4uScheduleToBePaid.house.cinema.cinemaLocation}</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.numOfTickets"/>:</td>
                  <td>
                        <c:forEach items="${requestScope.t4uSeatsSelected}" var="seats">
                            ${seats}&nbsp;
                        </c:forEach>
                  </td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.total"/>:</td>
                  <td id="total">${requestScope.t4uNumOfSeatsCash}</td>
                </tr>
                <c:if test="${sessionScope.t4uUser.userGroup != 'officer'}">
                    <tr>
                    <td><fmt:message key="payment.form.userPoints"/>:</td>
                    <td>${sessionScope.t4uUser.userCredit}</td>
                  </tr>
                </c:if>
                
                
              </tbody>
            </table>
                <form id="cart" action="/T4U/user/myCart" method ="POST"></form>
            <form role="form" method="POST" action="/T4U/pay">
                <input type="hidden" name="scheduleId" value="${requestScope.t4uScheduleToBePaid.scheduleId}"/>
                <input type="hidden" name="seats" value="${requestScope.t4uSeatsSelected}"/>
                <input type="hidden" name="userGroup" value="${sessionScope.t4uUser.userGroup}"/>
                <input type="hidden" name="userCredit" value="${sessionScope.t4uUser.userCredit}"/>
                    <input type="hidden" name="userId" value="${sessionScope.t4uUser.userId}"/>
                    <c:if test="${sessionScope.t4uUser.userGroup != 'officer'}" >
                    <div class="form-group">
                      <label for="cardNo"><fmt:message key="payment.form.cardNo"/></label>
                      <input type="text" class="form-control" id="cardNo" name="cardNo" maxlength="16">
                    </div>
                    <div class="form-group">
                      <label for="cardPwd"><fmt:message key="payment.form.cardPwd"/></label>
                      <input type="password" class="form-control" id="cardPwd" name="cardPwd" maxlength="3">
                    </div>
                    </c:if>
                      <c:if test="${sessionScope.t4uUser.userGroup != 'officer'}">
                        <div class="checkbox">
                             <label>
                                 <input type="checkbox"> <fmt:message key="payment.form.useCredit"/>
                             </label>
                             <div id="payCredit">

                             </div>
                         </div>
                      </c:if>
                <c:choose>
                    <c:when test="${sessionScope.t4uUser.userGroup == 'officer'}" >
                        <button type="button" id="addToCart" class="btn btn-warning"><fmt:message key="payment.form.addToCart"/></button>        
                    </c:when>
                    <c:otherwise>
                        <button type="button" id="buy" class="btn btn-primary"><fmt:message key="payment.form.submit"/></button>
                    </c:otherwise>
                </c:choose>
              </form>
          </div>
        </div>
      </div>

    </div>
    </div>
        
        
        
    </body>
    <script>
        function showErrorMessage(msg){
                $.notify(msg, {
                                globalPosition: "top left",
                                autoHideDelay: 5000});
        }
        $(document).ready(function(){
            $('td').css("font-family", "monospace");
        });
        $('#buy').click(function(){
            if($("#demo5").val()> ${sessionScope.t4uUser.userCredit}){
                showErrorMessage('<fmt:message key="payment.form.notEnoughPoints"/>');
            }else if($("#demo5").val()> ${requestScope.t4uNumOfSeatsPoints}){
                showErrorMessage('<fmt:message key="payment.form.exceed"/>');
            }else{
                if($('#total').html()!=0){
                    if($("#cardNo").val()==''){
                        showErrorMessage('<fmt:message key="notify.message.provideBankCard"/>');
                    }else if($("#cardPwd").val()==''){
                        showErrorMessage('<fmt:message key="notify.message.providePwd"/>');
                    }else{
                        $('form').append('<input type="hidden" name="bankcard" value="'+$('#total').html()+'"/>');
                        $('form').submit();
                    }
                }else{
                    $('form').submit();
                }
            }
            
        });
        $('#addToCart').click(function(){
            
            $('#cart').append(
                    '<input type="hidden" name="scheduleId" value="${requestScope.t4uScheduleToBePaid.scheduleId}"/>'+
                    '<input type="hidden" name="seats" value="${requestScope.t4uSeatsSelected}"/>'
                    );
            $('#cart').submit();
            
            
        });
        
        $('input[type="checkbox"]').change(function() {
            if($(this).is(":checked")) {
                $("#payCredit").append(
                    '<input id="demo5" type="text" class="form-control" name="demo5" value="0">'
                    
                    );

                $("#demo5").TouchSpin({
                    min:0,
                    max:100000
                });
                
                $("#demo5").change(function(){
                    var value =( ${requestScope.t4uNumOfSeatsCash} ).toFixed(2)- ($("#demo5").val()/10).toFixed(2);
                    $('#total').html('');
                    if(value < 0)
                        $('#total').html(0);
                    else
                        $('#total').html(value);
                });
                
            }else{
                $("#payCredit").html('');
                $('#total').html('');
                $('#total').html('${requestScope.t4uNumOfSeatsCash}');
            }
        
        });
    </script>
</html>
</fmt:bundle>