<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>实验室查询 - 高校实验室预约系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>
    <header class="topbar">
        <div class="brand">
            <span class="logo-icon">
                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M9 3h6M10 3v5.2L5.6 18a1.6 1.6 0 0 0 1.4 2.4h10a1.6 1.6 0 0 0 1.4-2.4L14 8.2V3"
                          stroke="#ffffff" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M7.5 14h9" stroke="#ffffff" stroke-width="1.8" stroke-linecap="round"/>
                </svg>
            </span>
            <span class="logo-text">高校实验室预约系统</span>
        </div>
        <div class="user-info">
            <c:if test="${not empty sessionScope.loginUser}">
                <span>${sessionScope.loginUser.realName}</span>
                <span class="role-tag">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.userRole == 'ADMIN'}">管理员</c:when>
                        <c:otherwise>用户</c:otherwise>
                    </c:choose>
                </span>
                <a href="${pageContext.request.contextPath}/login.jsp">退出</a>
            </c:if>
        </div>
    </header>

    <div class="container">
        <div class="page-header">
            <h1>实验室查询</h1>
            <p class="page-desc">查询当前可用的实验室，并可查看每个实验室的开放时段。</p>
        </div>

        <c:if test="${param.success == '1'}">
            <div class="alert alert-success">预约申请已提交，请等待管理员审批。</div>
        </c:if>

        <div class="panel">
            <form class="search-bar" action="${pageContext.request.contextPath}/labSearch" method="get">
                <div class="form-field">
                    <label for="minPeople">最少容纳人数</label>
                    <input type="number" id="minPeople" name="minPeople" value="${minPeople}" min="1" />
                </div>
                <button type="submit" class="btn btn-primary">查询</button>
            </form>
        </div>

        <div class="panel">
            <c:choose>
                <c:when test="${empty labs}">
                    <div class="empty">没有符合条件的可用实验室</div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrap">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>实验室名称</th>
                                    <th>容纳人数</th>
                                    <th>可用时段</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lab" items="${labs}">
                                    <tr>
                                        <td>${lab.labName}</td>
                                        <td>${lab.maxPeople} 人</td>
                                        <td>
                                            <div class="time-chips">
                                                <c:forEach var="time" items="${lab.availableTimes}">
                                                    <span class="chip">${time}</span>
                                                </c:forEach>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${lab.status == 'AVAILABLE'}">
                                                    <span class="badge badge-success">可用</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-warning">${lab.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a class="btn btn-primary btn-sm"
                                               href="${pageContext.request.contextPath}/reservation/apply?labId=${lab.labId}">预约</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
