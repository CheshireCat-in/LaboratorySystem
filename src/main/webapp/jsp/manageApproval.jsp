<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>审批管理 - 高校实验室预约系统</title>
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
            <h1>审批管理</h1>
            <p class="page-desc">查看并处理待审批的实验室预约申请。</p>
        </div>

        <c:if test="${param.msg == 'success'}">
            <div class="alert alert-success">审批操作成功</div>
        </c:if>
        <c:if test="${param.msg == 'fail'}">
            <div class="alert alert-error">审批操作失败，请重试</div>
        </c:if>
        <c:if test="${param.msg == 'invalid'}">
            <div class="alert alert-error">参数无效</div>
        </c:if>
        <c:if test="${param.msg == 'notfound'}">
            <div class="alert alert-error">未找到该申请</div>
        </c:if>

        <div class="panel">
            <c:choose>
                <c:when test="${empty pendingList}">
                    <div class="empty">暂无待审批的预约申请</div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrap">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>申请编号</th>
                                    <th>申请人</th>
                                    <th>实验室</th>
                                    <th>预约时段</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${pendingList}">
                                    <tr>
                                        <td>#${r.applyId}</td>
                                        <td>${r.realName}</td>
                                        <td>${r.labName}</td>
                                        <td>
                                            <fmt:formatDate value="${r.bookStartTime}" pattern="yyyy-MM-dd HH:mm" />
                                            ~
                                            <fmt:formatDate value="${r.bookEndTime}" pattern="HH:mm" />
                                        </td>
                                        <td><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td><span class="badge badge-warning">待审批</span></td>
                                        <td>
                                            <a class="btn btn-primary btn-sm"
                                               href="${pageContext.request.contextPath}/approval?action=detail&applyId=${r.applyId}">审批</a>
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
