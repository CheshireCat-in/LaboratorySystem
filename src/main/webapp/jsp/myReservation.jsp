<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的预约 - 高校实验室预约系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
</head>
<body>
    <%@ include file="/common/navbar.jsp" %>

    <div class="container">
        <div class="page-header">
            <h1>我的预约</h1>
            <p class="page-desc">查看您的预约记录，待审核的预约可取消，已批准的可去签到。</p>
        </div>

        <div class="panel">
            <c:choose>
                <c:when test="${empty reservationList}">
                    <div class="empty">暂无预约记录</div>
                    <div style="text-align:center;margin-top:12px;">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/labSearch">去预约实验室</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-wrap">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>申请编号</th>
                                    <th>实验室</th>
                                    <th>预约时段</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${reservationList}">
                                    <tr>
                                        <td>#${r.applyId}</td>
                                        <td>${r.labName}</td>
                                        <td>
                                            <fmt:formatDate value="${r.bookStartTime}" pattern="yyyy-MM-dd HH:mm" />
                                            ~
                                            <fmt:formatDate value="${r.bookEndTime}" pattern="HH:mm" />
                                        </td>
                                        <td><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>
                                            <%-- 预约审批状态 --%>
                                            <c:choose>
                                                <c:when test="${r.applyStatus == 'PENDING'}">
                                                    <span class="badge badge-warning">待审核</span>
                                                </c:when>
                                                <c:when test="${r.applyStatus == 'APPROVED'}">
                                                    <span class="badge badge-success">已批准</span>
                                                </c:when>
                                                <c:when test="${r.applyStatus == 'REJECTED'}">
                                                    <span class="badge badge-danger">已驳回</span>
                                                </c:when>
                                                <c:when test="${r.applyStatus == 'CANCELLED'}">
                                                    <span class="badge" style="color:#6b7280;background:#f3f4f6;">已取消</span>
                                                </c:when>
                                            </c:choose>

                                            <%-- 签到履约状态（只有 APPROVED 的才有签到记录）--%>
                                            <c:if test="${r.applyStatus == 'APPROVED'}">
                                                <c:choose>
                                                    <c:when test="${r.performanceStatus == 'VIOLATED'}">
                                                        <br/>
                                                        <span class="badge badge-danger" style="font-size:11px;">
                                                            ⚠ 违约未到（已扣10分）
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${r.performanceStatus == 'NORMAL' and not empty r.checkInTime}">
                                                        <br/>
                                                        <span class="badge badge-success" style="font-size:11px;">
                                                            ✓ 已签到
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${r.performanceStatus == 'NORMAL' and empty r.checkInTime}">
                                                        <br/>
                                                        <span class="badge" style="font-size:11px;color:#6b7280;background:#f3f4f6;">
                                                            待签到
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.applyStatus == 'PENDING'}">
                                                    <a class="btn btn-danger btn-sm"
                                                       href="${pageContext.request.contextPath}/cancelReservation?applyId=${r.applyId}"
                                                       onclick="return confirm('确认取消这条预约？');">取消</a>
                                                </c:when>
                                                <c:when test="${r.applyStatus == 'APPROVED'}">
                                                    <a class="btn btn-primary btn-sm"
                                                       href="${pageContext.request.contextPath}/checkIn?applyId=${r.applyId}">去签到</a>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
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
