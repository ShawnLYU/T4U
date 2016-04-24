<%-- 
    Document   : userDropDownMenu
    Created on : 2016-4-24, 20:04:29
    Author     : Steven
--%>

                                <ul class="dropdown-menu">
                                        <c:choose>
                                            <c:when test="${sessionScope.t4uUser != null}">
                                               <li><a href="/T4U/user/profile"><fmt:message key="index.label.profile"/></a></li>
                                            </c:when>
                                            <c:otherwise>
                                               <li><a href="/T4U/login.jsp"><fmt:message key="index.label.login"/></a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    <li><a href="/T4U/register.jsp"><fmt:message key="index.label.register"/></a></li>
                                    <li class="divider"></li>
                                    <li><a href="/T4U/user/logout.do"><fmt:message key="index.label.logout"/></a></li>
                                </ul>
