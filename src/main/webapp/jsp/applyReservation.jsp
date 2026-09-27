<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>提交预约申请 - 高校实验室预约系统</title>
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
            <h1>提交预约申请</h1>
            <p class="page-desc">选择预约日期与开放时段，提交后等待管理员审批。</p>
        </div>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">${errorMsg}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty lab}">
                <div class="panel">
                    <div class="empty">未找到该实验室，或该实验室当前不可用</div>
                    <div style="text-align:center;margin-top:12px;">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/labSearch">返回查询</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="panel">
                    <table class="detail-list">
                        <tr>
                            <th>实验室名称</th>
                            <td>${lab.labName}</td>
                        </tr>
                        <tr>
                            <th>容纳人数</th>
                            <td>${lab.maxPeople} 人</td>
                        </tr>
                        <tr>
                            <th>状态</th>
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
                        </tr>
                    </table>

                    <form action="${pageContext.request.contextPath}/reservation/apply" method="post">
                        <input type="hidden" name="labId" value="${lab.labId}" />

                        <div class="form-field" style="margin-bottom:20px;">
                            <label for="bookDate">预约日期</label>
                            <input type="date" id="bookDate" name="bookDate" required />
                        </div>

                        <div class="form-field" style="margin-bottom:20px;">
                            <label>选择时段</label>
                            <div class="slot-selector">
                                <c:forEach var="time" items="${lab.availableTimes}">
                                    <label class="slot-option">
                                        <input type="radio" name="timeSlot" value="${time}" required />
                                        <span class="slot-label">${time}</span>
                                    </label>
                                </c:forEach>
                            </div>
                            <c:if test="${empty lab.availableTimes}">
                                <p style="color:#6b7280;font-size:13px;">该实验室暂无可选时段</p>
                            </c:if>
                        </div>

                        <div style="display:flex;gap:12px;margin-top:24px;">
                            <button type="submit" class="btn btn-primary">提交预约</button>
                            <a class="btn btn-ghost" href="${pageContext.request.contextPath}/labSearch">返回</a>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
