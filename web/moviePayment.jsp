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
                  <td><fmt:message key="payment.form.priceCard"/>:</td>
                  <td>${requestScope.t4uNumOfSeatsCash}</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.pricePoints"/>:</td>
                  <td>${requestScope.t4uNumOfSeatsPoints}</td>
                </tr>
                <tr>
                  <td><fmt:message key="payment.form.userPoints"/>:</td>
                  <td>${sessionScope.t4uUser.userCredit}</td>
                </tr>
              </tbody>
            </table>
                
            <form role="form" method="POST" action="/T4U/pay">
                <input type="hidden" name="scheduleId" value="${requestScope.t4uScheduleToBePaid.scheduleId}"/>
                <input type="hidden" name="seats" value="${requestScope.t4uSeatsSelected}"/>
                
                <c:if test="${sessionScope.t4uUser.userGroup == 'user'}">
                    <input type="hidden" name="userId" value="${sessionScope.t4uUser.userId}"/>
                    <div class="form-group">
                        <label for="exampleSelect1"><fmt:message key="payment.form.payWay"/></label>
                        <div class="input-group">
                            <select class="form-control" id="exampleSelect1" name="payMethod">
                                <option value="1"><fmt:message key="payment.form.cardOnly"/></option>
                                <option value="2"><fmt:message key="payment.form.creditOnly"/></option>
                                <option value="3"><fmt:message key="payment.form.both"/></option>
                            </select>
                            <input id="demo5" type="text" class="form-control" name="demo5" value="50">
                        </div>
                    </div>
                    <div class="form-group">
                      <label for="cardNo"><fmt:message key="payment.form.cardNo"/></label>
                      <input type="text" class="form-control" id="cardNo" name="cardNo" maxlength="16">
                    </div>
                    <div class="form-group">
                      <label for="cardPwd"><fmt:message key="payment.form.cardPwd"/></label>
                      <input type="password" class="form-control" id="cardPwd" name="cardPwd" maxlength="3">
                    </div>
                </c:if>
                
                <button type="button" class="btn btn-primary"><fmt:message key="payment.form.submit"/></button>
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
            $("#demo5").prop('disabled', true);
            $('td').css("font-family", "monospace");
            $("#demo5").TouchSpin({
                postfix: "$",
                min:1,
                max: ${requestScope.t4uNumOfSeatsCash}-1
            });
            $("#exampleSelect1").change(function(){
                if($("#exampleSelect1").val()==1){
                    $("#cardNo").prop('disabled', false);
                    $("#cardPwd").prop('disabled', false);
                    $("#demo5").prop('disabled', true);
                }else if($("#exampleSelect1").val()==2){
                    $("#cardNo").prop('disabled', true);
                    $("#cardPwd").prop('disabled', true);
                    $("#demo5").prop('disabled', true);
                }else{
                    $("#cardNo").prop('disabled', false);
                    $("#cardPwd").prop('disabled', false);
                    $("#demo5").prop('disabled', false);
                }
            });
        });
        $('button[type="button"]').click(function(){
            if($("#exampleSelect1").val()==1){
                if($("#cardNo").val()==''){
                    showErrorMessage('<fmt:message key="notify.message.provideBankCard"/>');
                }else if($("#cardPwd").val()==''){
                    showErrorMessage('<fmt:message key="notify.message.providePwd"/>');
                }else{
                    $('form').submit();
                }
            }else if($("#exampleSelect1").val()==2){
                if(${sessionScope.t4uUser.userCredit}<${requestScope.t4uNumOfSeatsPoints}){
                    showErrorMessage('<fmt:message key="notify.message.pointsNotEnough"/>');
                }else{
                    $('form').submit();
                }
            }else{
                if($("#demo5").val()*10>${sessionScope.t4uUser.userCredit}){
                    showErrorMessage('<fmt:message key="notify.message.pointsNotEnough"/>');
                }else if($("#cardNo").val()==''){
                    showErrorMessage('<fmt:message key="notify.message.provideBankCard"/>');
                }else if($("#cardPwd").val()==''){
                    showErrorMessage('<fmt:message key="notify.message.providePwd"/>');
                }else{
                    $('form').submit();
                }
            }
        });
    </script>
</html>
</fmt:bundle>