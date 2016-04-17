<%-- 
    Document   : modalForms
    Created on : Apr 17, 2016, 11:22:38 AM
    Author     : mengxualv2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="lan" value="com.ss.i18n.T4uUI" scope="application" />
<fmt:bundle basename="${lan}">
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
                              <input type="text" class="form-control" id="name" >
                            </div>
                            <div class="form-group">
                              <label for="phone"><fmt:message key="register.label.phone"/><label>*</label></label>
                              <input type="text" class="form-control" id="phone" >
                            </div>
                            <div class="form-group">
                              <label for="account"><fmt:message key="register.label.account"/></label>
                              <input type="text" class="form-control " readonly id="account" value="${sessionScope.t4uUser.userAccount}">
                            </div>
                            <div class="form-group">
                              <label for="email"><fmt:message key="register.label.email"/><label>*</label></label>
                              <input type="text" class="form-control" id="email"> 
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
                              <label for="oldPwd"><fmt:message key="profile.label.oldPwd"/></label>
                              <input type="text" class="form-control " id="oldPwd">
                            </div>
                            <div class="form-group">
                              <label for="newPwd"><fmt:message key="profile.label.newPwd"/></label>
                              <input type="text" class="form-control " id="newPwd">
                            </div>
                            <div class="form-group">
                              <label for="confirmPwd"><fmt:message key="profile.label.confirmPwd"/></label>
                              <input type="text" class="form-control " id="confirmPwd">
                            </div>
                        </form>
                      </div>
                      <div class="modal-footer">
                        <button type="button" id=updatePwdConfirm"" class="btn btn-primary"><fmt:message key="profile.label.confirm"/></button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><fmt:message key="profile.label.cancel"/></button>
                      </div>
                    </div>

                  </div>
                </div>
                      </fmt:bundle>