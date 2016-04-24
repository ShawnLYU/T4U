<%-- 
    Document   : seatPlan
    Created on : Apr 11, 2016, 8:41:10 PM
    Author     : Steven
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
<c:set var="schedule" value="${requestScope.t4uUserCurSchedule}" />
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

        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<!--        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />-->
        <!-- jQuery Seat Plan -->
        <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
        <link href="/T4U/resources/css/jquery.seat-charts.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/T4U/resources/css/style_seat.css" rel="stylesheet" type="text/css" media="all" />
        <script src="/T4U/resources/js/jquery.seat-charts.js"></script>
        
    </head>
    <body>
        <div class="col-sm-8 col-sm-offset-2">
            <fmt:bundle basename="${lan}">
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
                                <%@include file="userDropDownMenu.jsp" %>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="error-404">
                            <div class="wrapper">
                                <div class="container">
                                    <div id="seat-map">
                                        <div class="front-indicator"><fmt:message key="seat.label.screen"/></div>
                                    </div>
                                    <div class="booking-details">
                                        <div id="legend"></div>
                                        <h2><fmt:message key="seat.label.detail"/></h2>
                                        <h3> <fmt:message key="seat.label.selected"/> (<span id="counter">0</span>):</h3>
                                        <ul id="selected-seats" class="list-group"></ul>
                                        <fmt:message key="seat.label.total"/>: <b>$<span id="total">0</span></b>
                                        <button id="pay" class="btn btn-info checkout-button"><fmt:message key="seat.label.checkout"/> &raquo;</button>
                                    </div>
                                </div>
                            </div>
                                    <form id="myForm" method="POST" action = "/T4U/confirm"></form>
                                        <!--modal for customer account input-->
                                        <div class="modal fade" id="myModal" role="dialog">
                                                <div class="modal-dialog">

                                                        <!-- Modal content-->
                                                        <div class="modal-content">
                                                                <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                        <h4 class="modal-title"><fmt:message key="seat.label.customerAccount"/></h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                        <input type="text" class="form-control" id="customerAccount" name="customerAccount" maxlength="16">
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" id="add" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                                                                    <button type="button" id="cancelCustomer" class="btn btn-warning"><fmt:message key="profile.label.cancel"/></button>
                                                                </div>
                                                        </div>

                                                </div>
                                        </div>
                            <script>
                                $("#add").click(function(){
                                    $('#myModal').modal('toggle');
                                     $("#pay").click();
                                });
                                $("#cancelCustomer").click(function(){
                                    $("#customerAccount").val('');
                                    $('#myModal').modal('toggle');
                                });

                            </script>
                            <script>
                                function showErrorMessage(msg){
                                        $.notify(msg, {
                                                        globalPosition: "top left",
                                                        autoHideDelay: 5000});
                                }
                                $(document).ready(function() {
                                    <c:if test="${sessionScope.errorNoCustomer != null}" >
                                            showErrorMessage('<fmt:message key="error.login.e1"/>');
                                    </c:if>
                                    var $cart = $('#selected-seats'),
                                        $counter = $('#counter'),
                                        $total = $('#total'),
                                        sc = $('#seat-map').seatCharts({
                                        map: <c:out value="${schedule.house.housePlan}" escapeXml="false" />,
                                        seats: {
                                            e: {
                                                price   : <c:out value="${schedule.price}" />,
                                                classes : 'economy-class', //your custom CSS class
                                                category: 'Economy Class'
                                            }                   

                                        },
                                        naming : {
                                            top : false,
                                            rows: ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'],
                                            getLabel : function (character, row, column) {
                                                return column;
                                            },
                                            getId : function(character, row, column) {
                                                return row + column;
                                            },
                                        },
                                        legend : {
                                            node : $('#legend'),
                                            items : [
                                                [ 'e', 'available',   '<fmt:message key="seat.label.available"/>'],
                                                [ 'e', 'sold',   '<fmt:message key="seat.label.sold"/>'],
                                                [ 'e', 'unavailable', '<fmt:message key="seat.label.unavailable"/>']
                                            ]                   
                                        },
                                        click: function () {
                                            if (this.status() == 'available') {
                                                //let's create a new <li> which we'll add to the cart items
                                                $('<li class="list-group-item">Seat '+this.settings.id+'&nbsp;&nbsp;: &nbsp;&nbsp;&nbsp;&nbsp;<b>$'+this.data().price+'</b> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                                    .attr('id', 'cart-item-'+this.settings.id)
                                                    .data('seatId', this.settings.id)
                                                    .appendTo($cart);

                                                /*
                                                 * Lets update the counter and total
                                                 *
                                                 * .find function will not find the current seat, because it will change its stauts only after return
                                                 * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
                                                 */
                                                $counter.text(sc.find('selected').length+1);
                                                $total.text(recalculateTotal(sc)+this.data().price);

                                                return 'selected';
                                            } else if (this.status() == 'selected') {
                                                //update the counter
                                                $counter.text(sc.find('selected').length-1);
                                                //and total
                                                $total.text(recalculateTotal(sc)-this.data().price);

                                                //remove the item from our cart
                                                $('#cart-item-'+this.settings.id).remove();

                                                //seat has been vacated
                                                return 'available';
                                            } else if (this.status() == 'sold') {
                                                //seat has been already booked
                                                return 'sold';
                                            } else if (this.status() == 'unavailable') {
                                                //seat was unavailable
                                                return 'unavailable';
                                            } else {
                                                return this.style();
                                            }
                                        }
                                    });

                                    //this will handle "[cancel]" link clicks
                                    $('#selected-seats').on('click', '.cancel-cart-item', function () {
                                        //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here
                                        sc.get($(this).parents('li').data('seatId')).click();
                                        return false;
                                    });

                                    //let's pretend some seats have already been booked
                                    sc.get([<c:out value="${schedule.scheduleOSeats}" escapeXml="false" />]).status('sold');
                                    sc.get([<c:out value="${schedule.scheduleUSeats}" escapeXml="false" />]).status('unavailable');

                                });
                                
                                $("#pay").click(function(){
                                    var seatsSeleted = [];
                                    $('.selected').each(function () {
                                        seatsSeleted.push($(this).attr("id"));
                                     });
                                     if(seatsSeleted.length==0){
                                         showErrorMessage('<fmt:message key="seat.error.notSelected"/>');
                                     }
                                     <c:if test="${sessionScope.t4uUser.userGroup == 'officer'}">
                                     else if($("#customerAccount").val()==''){
                                         $('#myModal').modal('toggle');
                                    }
                                        
                                    </c:if>



                                     else{
                                        $('#myForm').append('<input type="hidden" name="seats" value='+seatsSeleted+' />');
                                        $('#myForm').append('<input type="hidden" name="scheduleId" value="${schedule.scheduleId}" />');
                                        $('#myForm').append('<input type="hidden" name="userId" value="${sessionScope.t4uUser.userId}" />');
                                        <c:if test="${sessionScope.t4uUser.userGroup == 'officer'}">
                                        $('#myForm').append('<input type="hidden" name="userAccount" value="'+$("#customerAccount").val()+'" />');
                                       </c:if>
                                        
                                        $("#myForm").submit(); 
                                     }
                                });

                                function recalculateTotal(sc) {
                                    var total = 0;

                                    //basically find every selected seat and sum its price
                                    sc.find('selected').each(function () {
                                        total += this.data().price;
                                    });

                                    return total;
                                }

                            </script>
                        </div>		
                    </div>
                </div>
                </fmt:bundle>
                <jsp:include page="footer_normal.jsp" />
                