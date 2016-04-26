<%-- 
    Document   : error
    Created on : Apr 11, 2016, 8:41:10 PM
    Author     : mengxualv2
--%>

<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <script src="/T4U/resources/js/jquery.dataTables.min.js"></script>
        <script src="/T4U/resources/js/jquery.bootstrap-touchspin.js"></script>
        
        <link href="/T4U/resources/css/style_profile.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
<!--        <link href="resources/css/common.css" rel="stylesheet" type='text/css' />-->
        <link href="/T4U/resources/css/bootstrap-switch.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
        <link href="/T4U/resources/bootstrap-3.3.6/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
        <link href="/T4U/resources/css/style_error.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/T4U/resources/css/jquery.dataTables.min.css" rel="stylesheet"/>
        <link href="resources/css/jquery.bootstrap-touchspin.css" rel="stylesheet" type='text/css' />
        <script>
        $(document).ready(function(){
            <c:if test="${not empty requestScope.error}" >
                    showErrorMessage('<fmt:message key="schedule.msg.error" />');
            </c:if>
                <c:if test="${not empty requestScope.success}" >
                    showSuccessMessage('<fmt:message key="schedule.msg.success" />');
            </c:if>
            var allHouses = [];
            var allCinemas = [];
            var aCinemaName;
            <c:forEach items="${sessionScope.T4uAllHouses}" var="house">
                allHouses.push('${house.value.houseId}');
            </c:forEach>
            <c:forEach items="${sessionScope.T4uAllHouses}" var="house">
                allCinemas.push('${house.value.cinema.cinemaName}');
            </c:forEach>
            var table = $('#example').DataTable( {
                "oSearch": {"bSmart": false}
            });
            $('#example tbody').on( 'click', 'tr', function () {
                if ( $(this).hasClass('selected') ) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
            $(".priceInput").TouchSpin({
                min:0,
                max:100000
            });
            $('#datetimepicker1').datetimepicker({
                viewMode: 'years'
             });
             $('#datetimepicker2').datetimepicker({
                viewMode: 'years'
             });
             $(document).on("change", "#houseNameInsert", function(event){
                 var aHouseId = $("#houseNameInsert").val();
                    for(var i=0;i<allHouses.length;i++){
                        if(allHouses[i]==aHouseId){
                            aCinemaName = allCinemas[i];
                            break;
                        }
                    }
                $("#cinemaNameInsert").val(aCinemaName);
                 
             });
             $("#insert").click(function(){
                $('#modalForInsert').modal('toggle');
                 var aHouseId = $("#houseNameInsert").val();
                    for(var i=0;i<allHouses.length;i++){
                        if(allHouses[i]==aHouseId){
                            aCinemaName = allCinemas[i];
                            break;
                        }
                    }
                $("#cinemaNameInsert").val(aCinemaName);
                
            });
            $(document).on("change", "#houseNameUpdate", function(event){
                   var aHouseId = $("#houseNameUpdate").val();
                    for(var i=0;i<allHouses.length;i++){
                        if(allHouses[i]==aHouseId){
                            aCinemaName = allCinemas[i];
                            break;
                        }
                    }
                $("#cinemaNameUpdate").val(aCinemaName);
            });
            $("#update").click(function(){
                if($("tr.selected").size()==0)
                    showErrorMessage('<fmt:message key="schedule.msg.notSelect" />');
                else{
                    $('#modalForUpdate').modal('toggle');
                    $("#cinemaNameUpdate").val($("tr.selected").find("td").eq(0).text());
//                    $("#houseNameUpdate").val($("tr.selected").find("td").eq(1).text());
                    $("#houseNameUpdate").filter(function() {
                        //may want to use $.trim in here
                        return $(this).text() == $("tr.selected").find("td").eq(1).text(); 
                    }).attr('selected', true);
                    $("#versionNameUpdate").val($("tr.selected").find("td").eq(2).text());
                    $("#priceUpdate").val($("tr.selected").find("td").eq(5).text());
                    if($("#form2").find("input[name='scheduleIdUpdate']").size()!=0){
                        $("#form2").find("input[name='scheduleIdUpdate']").remove();
                    }
                    $("#form2").append(
                        '<input name="scheduleIdUpdate" type="hidden" value="'+ $("tr.selected").attr('id') +'" />'
                    );
                    
                    
                }
                
                
                
                
            });
            $("#delete").click(function(){
                if($("tr.selected").size()==0)
                    showErrorMessage('<fmt:message key="schedule.msg.notSelect" />');
                else{
                    $('#modalForDelete').modal('toggle');
                    $("#cinemaNameDelete").val($("tr.selected").find("td").eq(0).text());
                    $("#houseNameDelete").val($("tr.selected").find("td").eq(1).text());
                    $("#versionNameDelete").val($("tr.selected").find("td").eq(2).text());
                    $("#scheduleTimeslotDelete").val($("tr.selected").find("td").eq(3).text());
                    $("#priceDelete").val($("tr.selected").find("td").eq(5).text());
                    if($("#form3").find("input[name='scheduleIdDelete']").size()!=0){
                        $("#form3").find("input[name='scheduleIdDelete']").remove();
                    }
                    $("#form3").append(
                        '<input name="scheduleIdDelete" type="hidden" value="'+ $("tr.selected").attr('id') +'" />'
                    );
                    
                }
            });
            $(document).on("click", "#doInsert", function(event){
                $("#form1").submit();
                $('#modalForInsert').modal('toggle');
            });
            $(document).on("click", "#doUpdate", function(event){
                $("#form2").submit();
                $('#modalForUpdate').modal('toggle');

            });
            $(document).on("click", "#doDelete", function(event){
                    $("#form3").submit();
                    $('#modalForDelete').modal('toggle');
        

            });
        });
        
        
        function showSuccessMessage(msg){
            $.notify(msg, {
                        globalPosition: "top left",
                        autoHideDelay: 5000,
                    className: 'success',});
        }
        function showErrorMessage(msg){
            $.notify(msg, {
                globalPosition: "top left",
                autoHideDelay: 5000});
        }
        </script>
    </head>
    <body>
        <body>
            <!-- Modal for insertion -->
                <div class="modal fade" id="modalForInsert" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><fmt:message key="schedule.button.insert"/></h4>
                      </div>
                      <div class="modal-body">
                        <form id="form1" action="/T4U/manage/updateSchedule" method="POST" role="form">
                            <input name='action' type='hidden' value='insert' />
                            <div class="form-group">
                              <label for="houseNameInsert"><fmt:message key="movieDetail.table.head.houseName"/><label>*</label></label>
                              <select class="form-control" id="houseNameInsert" name="houseId">
                                  <c:forEach items="${sessionScope.T4uAllHouses}" var="houses">
                                      <option value="${houses.value.houseId}">${houses.value.houseName}</option>
                                    </c:forEach>
                              </select>
                            </div>
                            <div class="form-group">
                              <label for="cinemaNameInsert"><fmt:message key="movieDetail.table.head.cinemaName"/><label>*</label></label>
                              <input type="text" class="form-control" readonly id="cinemaNameInsert" name="cinemaName">
                            </div>
                            <div class="form-group">
                              <label for="houseNameInsert"><fmt:message key="movieDetail.table.head.versionName"/></label>
                              <select class="form-control" id="versionNameInsert" name="versionId">
                              <c:forEach items="${sessionScope.T4uAllMovies}" var="movie">
                                      <c:forEach items="${movie.value.allVersions}" var="version">
                                        <option value="${version.value.versionId}">${version.value.versionName}</option>
                                        </c:forEach>
                                </c:forEach>
                              </select>
                            </div>
                            <div class="form-group">
                              <label for="date1"><fmt:message key="movieDetail.table.head.scheduleTimeslot"/><label>*</label></label>
                                <div class="input-group date" id="datetimepicker1" data-date-format="yyyy/mm/dd hh:ii:ss">
                                    <input type='text' name="scheduleTimeslot" class="form-control" id="date1"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><fmt:message key="movieDetail.table.head.versionPrice"/><label>*</label></label>
                                <input type="text" class="form-control priceInput" name="price" id="priceInsert" value="0">
                            </div>
                            
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button id="doInsert" type="button" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><fmt:message key="profile.label.cancel"/></button>
                      </div>
                    </div>

                  </div>
                </div>
                      <!-- Modal for update -->
                <div class="modal fade" id="modalForUpdate" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><fmt:message key="schedule.button.update"/></h4>
                      </div>
                      <div class="modal-body">
                        <form id="form2" action="/T4U/manage/updateSchedule" method="POST" role="form">
                            <input name='action' type='hidden' value='update' />
                            <div class="form-group">
                              <label for="houseNameUpdate"><fmt:message key="movieDetail.table.head.houseName"/><label>*</label></label>
                              <select class="form-control" id="houseNameUpdate" name="houseId">
                                  <c:forEach items="${sessionScope.T4uAllHouses}" var="houses">
                                      <option value="${houses.value.houseId}">${houses.value.houseName}</option>
                                    </c:forEach>
                              </select>
                            </div>
                            <div class="form-group">
                              <label for="cinemaNameUpdate"><fmt:message key="movieDetail.table.head.cinemaName"/><label>*</label></label>
                              <input type="text" class="form-control" readonly id="cinemaNameUpdate" name="cinemaName">
                            </div>
                            <div class="form-group">
                              <label for="houseNameUpdate"><fmt:message key="movieDetail.table.head.versionName"/></label>
                              <select class="form-control" id="versionNameUpdate" name="versionId">
                              <c:forEach items="${sessionScope.T4uAllMovies}" var="movie">
                                      <c:forEach items="${movie.value.allVersions}" var="version">
                                        <option value="${version.value.versionId}">${version.value.versionName}</option>
                                        </c:forEach>
                                </c:forEach>
                              </select>
                            </div>
                            <div class="form-group">
                              <label for="date2"><fmt:message key="movieDetail.table.head.scheduleTimeslot"/><label>*</label></label>
                                <div class="input-group" id="datetimepicker2">
                                    <input type='text' name="scheduleTimeslot" class="form-control" id="date2"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><fmt:message key="movieDetail.table.head.versionPrice"/><label>*</label></label>
                                <input type="text" class="form-control priceInput" name="price" id="priceUpdate" value="0">
                            </div>
                            
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button id="doUpdate" type="button" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><fmt:message key="profile.label.cancel"/></button>
                      </div>
                    </div>

                  </div>
                </div>
                      
                    <!-- Modal for delete -->
                <div class="modal fade" id="modalForDelete" role="dialog">
                  <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><fmt:message key="schedule.button.delete"/></h4>
                      </div>
                      <div class="modal-body">
                        <form id="form3" action="/T4U/manage/updateSchedule" method="POST" role="form">
                            <input name='action' type='hidden' value='delete' />
                            <input name="scheduleId" type="hidden" />
                            <div class="form-group">
                              <label for="cinemaNameDelete"><fmt:message key="movieDetail.table.head.cinemaName"/><label>*</label></label>
                              <input type="text" class="form-control" readonly id="cinemaNameDelete" name="cinemaName">
                            </div>
                            <div class="form-group">
                              <label for="houseNameDelete"><fmt:message key="movieDetail.table.head.versionName"/></label>
                              <input type="text" class="form-control" readonly id="houseNameDelete" name="houseName">
                            </div>
                              <div class="form-group">
                              <label for="versionNameDelete"><fmt:message key="movieDetail.table.head.versionName"/></label>
                              <input type="text" readonly class="form-control" readonly id="versionNameDelete" name="versionName">
                            </div>
                            <div class="form-group">
                              <label for="scheduleTimeslotDelete"><fmt:message key="movieDetail.table.head.scheduleTimeslot"/><label>*</label></label>
                                <input type="text" readonly class="form-control" readonly id="scheduleTimeslotDelete" name="scheduleTimeslot">
                            </div>
                            <div class="form-group">
                                <label><fmt:message key="movieDetail.table.head.versionPrice"/><label>*</label></label>
                                <input type="text" readonly class="form-control" id="priceDelete" name="price" value="0">
                            </div>
                            
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button id="doDelete" type="button" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><fmt:message key="profile.label.cancel"/></button>
                      </div>
                    </div>

                  </div>
                </div>
                      
		<div class="col-sm-8 col-sm-offset-2">
			<!-- header-section-starts -->
			<div class="full">
				<div class="menu">
				</div>
				<div class="main">
					<div class="single-content">
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
						<div class="reviews-section">
							<h4><fmt:message key="schedule.label.info"/></h4>
                                                            <table id="example" class="display col-sm-8 col-sm-offset-2" cellspacing="0" width="100%">
                                                                <thead>
                                                                    <tr>
                                                                        <th><fmt:message key="movieDetail.table.head.cinemaName"/></th>
                                                                        <th><fmt:message key="movieDetail.table.head.houseName"/></th>
                                                                        <th><fmt:message key="movieDetail.table.head.versionName"/></th>
                                                                        <th><fmt:message key="movieDetail.table.head.scheduleTimeslot"/></th>
                                                                        <th><fmt:message key="movieDetail.table.head.cinemaLocation"/></th>
                                                                        <th><fmt:message key="movieDetail.table.head.versionPrice"/></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${sessionScope.T4uAllSchedules}" var="schedule">
                                                                        <tr id="${schedule.scheduleId}">
                                                                            <td><c:out value="${schedule.house.cinema.cinemaName}"/></td>
                                                                            <td><c:out value="${schedule.house.houseName}"/></td>
                                                                            <td><c:out value="${schedule.version.versionName}"/></td>
                                                                            <td><c:out value="${schedule.scheduleTimeslot}"/></td>
                                                                            <td><c:out value="${schedule.house.cinema.cinemaLocation}"/></td>
                                                                            <td><c:out value="${schedule.price}" /></td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                                    <button type="button" id="insert" class="btn btn-primary"><fmt:message key="schedule.button.insert"/></button>        
                                                                    <button type="button" id="update" class="btn btn-primary"><fmt:message key="schedule.button.update"/></button>        
                                                                    <button type="button" id="delete" class="btn btn-primary"><fmt:message key="schedule.button.delete"/></button>        
							<div class="col-md-12 reviews-grids">
								<div class="review">
								<div class="single">
				  			</div>

							<div class="clearfix"></div>
						</div>
					</div>
                                </div>                
                
                
                </fmt:bundle>
                <jsp:include page="footer_normal.jsp" />
                