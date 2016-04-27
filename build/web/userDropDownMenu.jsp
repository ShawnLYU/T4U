<%-- 
    Document   : userDropDownMenu
    Created on : 2016-4-24, 20:04:29
    Author     : Steven
--%>
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
                                    <li><a href="/T4U/user/profile"><fmt:message key="index.label.profile"/></a></li>
                                        </c:when>
                                        <c:otherwise>
                                    <li><a href="/T4U/login.jsp"><fmt:message key="index.label.login"/></a></li>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${sessionScope.t4uUser.userGroup == 'admin'}">
                                    <li><a href="/T4U/manage/arrangeSeat"><fmt:message key="index.label.arrangeSeat"/></a></li>    
                                    <li><a href="/T4U/T4uGoToSchedule"><fmt:message key="index.label.schedule"/></a></li>    
                                    </c:if>
                                    <c:if test="${sessionScope.t4uUser.userGroup == 'officer'}">
                                    <li><a href="/T4U/GoToCartServlet"><fmt:message key="index.label.cart"/></a></li>
                                    <li><a href="/T4U/manage/refundList"><fmt:message key="index.label.approveRefund"/></a></li>    
                                    </c:if>
                                    <li><a href="/T4U/register.jsp"><fmt:message key="index.label.register"/></a></li>
                                    <li class="divider"></li>
                                    <li><a href="/T4U/user/logout.do"><fmt:message key="index.label.logout"/></a></li>
                                </ul>
                            </div>
