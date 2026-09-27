<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>审批详情 - 高校实验室预约系统</title>
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
            <h1>审批详情</h1>
            <p class="page-desc">查看预约申请信息，并执行通过或驳回操作。</p>
        </div>

        <div class="panel">
            <table class="detail-list">
                <tr>
                    <th>申请编号</th>
                    <td>#${reservation.applyId}</td>
                </tr>
                <tr>
                    <th>申请人</th>
                    <td>${reservation.realName}</td>
                </tr>
                <tr>
                    <th>实验室</th>
                    <td>${reservation.labName}</td>
                </tr>
                <tr>
                    <th>预约时段</th>
                    <td>
                        <fmt:formatDate value="${reservation.bookStartTime}" pattern="yyyy-MM-dd HH:mm" />
                        ~
                        <fmt:formatDate value="${reservation.bookEndTime}" pattern="yyyy-MM-dd HH:mm" />
                    </td>
                </tr>
                <tr>
                    <th>申请时间</th>
                    <td><fmt:formatDate value="${reservation.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                </tr>
                <tr>
                    <th>当前状态</th>
                    <td><span class="badge badge-warning">待审批</span></td>
                </tr>
            </table>

            <form action="${pageContext.request.contextPath}/approval?action=process" method="post">
                <input type="hidden" name="applyId" value="${reservation.applyId}" />

                <div class="form-field" style="margin-bottom:24px;">
                    <label for="opinion">审批意见（驳回时建议填写）</label>
                    <textarea id="opinion" name="opinion" placeholder="请输入审批意见"></textarea>
                </div>

                <div style="display:flex;gap:12px;">
                    <button type="submit" name="result" value="APPROVED" class="btn btn-primary">通过</button>
                    <button type="submit" name="result" value="REJECTED" class="btn btn-danger">驳回</button>
                    <a class="btn btn-ghost" href="${pageContext.request.contextPath}/approval">返回列表</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
