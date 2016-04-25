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
<c:set var="allSchedules" value="${requestScope.t4uAllSchedules}" />
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
        <div class="col-sm-10 col-sm-offset-1">
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
                                    <div class="row">
                                        <form role="form">
                                            <div class="form-group">
                                              <label for="sel1"><fmt:message key="seatPlan.selectSchedule"/>:</label>
                                              <select class="form-control input-sm" id="sel1">
                                                <c:forEach items="${allSchedules}" var="schedule">
                                                    <option value="${schedule.scheduleId}">
                                                        ${schedule.version.movie.movieName}&nbsp;
                                                        ${schedule.version.versionName}&nbsp;－&nbsp;
                                                        ${schedule.house.cinema.cinemaName}&nbsp;
                                                        ${schedule.house.houseName}&nbsp;－&nbsp;
                                                        ${schedule.scheduleTimeslot}
                                                    </option>
                                                </c:forEach>
                                              </select>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="row" id="mySeatChart">
                                        <div id="seat-map">
                                            <div class="front-indicator"><fmt:message key="seat.label.screen"/></div>
                                        </div>
                                        <div class="booking-details">
                                            <div id="legend"></div>
                                            <h2><fmt:message key="seatPlan.unavailableDetails"/></h2>
                                            <h3> <fmt:message key="seatPlan.unavailableSeat"/> (<span id="counter">0</span>):</h3>
                                            <ul id="selected-seats" class="list-group"></ul>
                                            <button id="confirm" class="btn btn-info checkout-button"><fmt:message key="seatPlan.confirm"/> &raquo;</button>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <script>
                                function showErrorMessage(msg){
                                        $.notify(msg, {
                                                        globalPosition: "top left",
                                                        autoHideDelay: 5000});
                                }
                                function showSuccessMessage(msg){
                                        $.notify(msg, {
                                                        globalPosition: "top left",
                                                        autoHideDelay: 5000,
                                                    className: 'success',});
                                }
                                $(document).on('click', '#confirm', function(){
                                    var seatsSeleted = [];
                                    $('.unavailable').each(function () {
                                        seatsSeleted.push($(this).attr("id"));
                                     });
                                     $.ajax({
                                            url : '/T4U/ArrangeSeatPlanServlet',
                                            type: "POST",
                                            dataType:'json',
                                            data : {
                                                    seats: seatsSeleted ,
                                                    scheduleId : $("#sel1").val()
                                           },
                                            
                                            error : function(data) {
                                                    $("#sel1").change();
                                                    if(data.responseText == 'success')
                                                        showSuccessMessage('<fmt:message key="notify.message.seatUpdateSuccess"/>');
                                                    else
                                                        showErrorMessage('<fmt:message key="notify.message.seatUpdateFailed"/>');
                                            },
                                            success : function(xhr) {
                                                    $("#sel1").change();
                                            }
                                        });
                                });
                                $(document).ready(function(){
                                    var $cart = $('#selected-seats'),
                                        $counter = $('#counter'),
                                        sc = $('#seat-map').seatCharts({
                                        map: <c:out value="${allSchedules[0].house.housePlan}" escapeXml="false" />,
                                        seats: {
                                            e: {
                                                price   : <c:out value="${allSchedules[0].price}" />,
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
                                                $('<li class="list-group-item">Seat '+this.settings.id+'&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<b></b> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                                    .attr('id', 'cart-item-'+this.settings.id)
                                                    .data('seatId', this.settings.id)
                                                    .appendTo($cart);
                                                /*
                                                 * Lets update the counter and total
                                                 *
                                                 * .find function will not find the current seat, because it will change its stauts only after return
                                                 * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
                                                 */
                                                $counter.text(sc.find('unavailable').length+1);
                                                return 'unavailable';
                                            } else if (this.status() == 'selected') {
                                                //update the counter
                                                $counter.text(sc.find('selected').length-1);
                                                //and total
                                                //remove the item from our cart
                                                $('#cart-item-'+this.settings.id).remove();
                                                //seat has been vacated
                                                return 'available';
                                            } else if (this.status() == 'sold') {
                                                //seat has been already booked
                                                return 'sold';
                                            } else if (this.status() == 'unavailable') {
                                                //seat was unavailable
                                                //update the counter
                                                $counter.text(sc.find('unavailable').length-1);
                                                //and total
                                                //remove the item from our cart
                                                $('#cart-item-'+this.settings.id).remove();
                                                return 'available';
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
                                    sc.get([<c:out value="${allSchedules[0].scheduleOSeats}" escapeXml="false" />]).status('sold');
                                    sc.get([<c:out value="${allSchedules[0].scheduleUSeats}" escapeXml="false" />]).status('unavailable');
                                    $counter.text(sc.find('unavailable').length);
                                     $("div").find(".unavailable").each(function(){
                                                        if(this.id!=''){
                                                            $('<li class="list-group-item">Seat '+this.id+'&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<b></b> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                                            .attr('id', 'cart-item-'+this.id)
                                                            .data('seatId', this.id)
                                                            .appendTo($cart);
                                                        }
                                                        
                                                    });
                                });
                                $("#sel1").change(function(){
                                    $.ajax({
                                            url : '/T4U/T4uGetAllScheduleServlet',
                                            data : {
                                                    scheduleId : $("#sel1").val()
                                            },
                                            error : function(xhr) {
                                                    alert('Error');
                                            },
                                            success : function(jsonObject) {
//                                                    alert('Success');
                                                    var price = jsonObject['price'];
                                                    var housePlan_tmp = jsonObject['house']['housePlan'];
                                                    var Oseats_tmp = jsonObject['scheduleOSeats'];
                                                    var Useats_tmp = jsonObject['scheduleUSeats'];
//                                                    alert(housePlan);
//                                                    alert(price);
//                                                    alert(Oseats);
//                                                    alert(Oseats);
//                                                    var seats = ['eeee_eeeeeeeeeee_ee','eeee_eeeeeeeeeee_ee','eeee_eeeeeeeeeee_ee','eeee_eeeeeeeeeee_ee','eeee_eeeeeeeeeee_ee','eee__eeeeeeeeeee_ee','_ee__eeeeeeeeeee_ee'];
                                                    
                                                    var housePlan = housePlan_tmp.split(",");
                                                    var Oseats = Oseats_tmp.split(",");
                                                    var Useats = Useats_tmp.split(",");
                                                    housePlan.splice(housePlan.length-1,1);
                                                    Oseats.splice(Oseats.length-1,1);
                                                    Useats.splice(Useats.length-1,1);
                                                    var arrayLength = Oseats.length;
                                                    for (var i = 0; i < arrayLength; i++) {
                                                        Oseats[i] = Oseats[i].substring(1,Oseats[i].length-1);
                                                    }
                                                    var useatsLength = Useats.length;
                                                    for (var i = 0; i < useatsLength; i++) {
                                                        Useats[i] = Useats[i].substring(1,Useats[i].length-1);
                                                    }
                                                    var housePlanLength = housePlan.length;
                                                    housePlan[0] = housePlan[0].substring(2,housePlan[0].length-1);
                                                    for (var i = 1; i < housePlanLength; i++) {
                                                        housePlan[i] = housePlan[i].substring(1,housePlan[i].length-1);
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    //jsonObject['house']['housePlan']
                                                    //clear original
                                                    $("#mySeatChart").html('');
                                                    $("#mySeatChart").append(
                                                            '<div id="seat-map">'+
                                                                '<div class="front-indicator"><fmt:message key="seat.label.screen"/></div>'+
                                                            '</div>'+
                                                            '<div class="booking-details">'+
                                                                '<div id="legend"></div>'+
                                                                '<h2><fmt:message key="seatPlan.unavailableDetails"/></h2>'+
                                                                '<h3> <fmt:message key="seatPlan.unavailableSeat"/> (<span id="counter">0</span>):</h3>'+
                                                                '<ul id="selected-seats" class="list-group"></ul>'+
                                                                '<button id="confirm" class="btn btn-info checkout-button"><fmt:message key="seatPlan.confirm"/> &raquo;</button>'+
                                                            '</div>'
                                                    );  
                                                    var $cart = $('#selected-seats'),
                                                        $counter = $('#counter'),
                                                        sc = $('#seat-map').seatCharts({
                                                        map: housePlan,
                                                        seats: {
                                                            e: {
                                                                price   : jsonObject['price'],
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
                                                                    $('<li class="list-group-item">Seat '+this.settings.id+'&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<b></b> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                                                        .attr('id', 'cart-item-'+this.settings.id)
                                                                        .data('seatId', this.settings.id)
                                                                        .appendTo($cart);
                                                                    /*
                                                                     * Lets update the counter and total
                                                                     *
                                                                     * .find function will not find the current seat, because it will change its stauts only after return
                                                                     * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
                                                                     */
                                                                    $counter.text(sc.find('unavailable').length+1);
                                                                    return 'unavailable';
                                                                } else if (this.status() == 'selected') {
                                                                    //update the counter
                                                                    $counter.text(sc.find('selected').length-1);
                                                                    //and total
                                                                    //remove the item from our cart
                                                                    $('#cart-item-'+this.settings.id).remove();
                                                                    //seat has been vacated
                                                                    return 'available';
                                                                } else if (this.status() == 'sold') {
                                                                    //seat has been already booked
                                                                    return 'sold';
                                                                } else if (this.status() == 'unavailable') {
                                                                    //seat was unavailable
                                                                    //update the counter
                                                                    $counter.text(sc.find('unavailable').length-1);
                                                                    //and total
                                                                    //remove the item from our cart
                                                                    $('#cart-item-'+this.settings.id).remove();
                                                                    return 'available';
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
                                                   
                                                    sc.get(Oseats).status('sold');
                                                    sc.get(Useats).status('unavailable');
                                                    $counter.text(sc.find('unavailable').length);
                                                    $("div").find(".unavailable").each(function(){
                                                        if(this.id!=''){
                                                            $('<li class="list-group-item">Seat '+this.id+'&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<b></b> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                                            .attr('id', 'cart-item-'+this.id)
                                                            .data('seatId', this.id)
                                                            .appendTo($cart);
                                                        }
                                                        
                                                    });
                                                    

                                            }
                                    });
                                });
                            </script>
                        </div>		
                    </div>
                </div>
                </fmt:bundle>
                <jsp:include page="footer_normal.jsp" />
                