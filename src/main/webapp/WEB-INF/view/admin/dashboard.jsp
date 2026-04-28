<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>대시보드 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.dash-wrap {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.stat-card {
    background: #fff;
    border-radius: 12px;
    padding: 24px;
    border: 1px solid #eee;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
}

.stat-card.center {
    align-items: center;
    text-align: center;
}

.stat-card.accent {
    background: linear-gradient(135deg, #6c63ff, #3b82f6);
    color: #fff;
    border: none;
    position: relative;
    cursor: pointer;
    transition: opacity 0.2s;
}

.stat-card.accent:hover {
    opacity: 0.9;
}

.stat-card.accent .stat-label {
    color: rgba(255,255,255,0.8);
}

.stat-card.accent .plus-btn {
    position: absolute;
    bottom: 16px;
    right: 16px;
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: rgba(255,255,255,0.3);
    color: #fff;
    font-size: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    line-height: 1;
}

.stat-label {
    font-size: 12px;
    color: #888;
    margin-bottom: 12px;
}

.stat-value {
    font-size: 26px;
    font-weight: 800;
}

.dash-middle {
    background: #fff;
    border-radius: 12px;
    border: 1px solid #eee;
    padding: 24px;
    overflow-x: auto;
}

.dash-bottom {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.dash-section {
    background: #fff;
    border-radius: 12px;
    border: 1px solid #eee;
    padding: 24px;
}

.dash-section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 16px;
    padding-bottom: 12px;
    border-bottom: 1px solid #f0f0f0;
}

.dash-section-title {
    font-size: 15px;
    font-weight: 700;
}

.dash-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #f5f5f5;
    font-size: 13px;
    gap: 8px;
}

.dash-row:last-child {
    border-bottom: none;
}
</style>

<div class="admin-page">
<div class="dash-wrap">

    <%-- 상단: 좌측 2x2 stat + 우측 결제내역 --%>
    <div style="display:grid; grid-template-columns:1fr 1.5fr; gap:20px; align-items:stretch;">

        <%-- 좌측 2x2 stat 카드 --%>
        <div style="display:grid; grid-template-columns:1fr 1fr; grid-template-rows:1fr 1fr; gap:16px;">

            <div class="stat-card center">
                <div class="stat-label">전체회원</div>
                <div class="stat-value">${totalMember != null ? totalMember : 0}</div>
            </div>

            <div class="stat-card accent center"
                 onclick="location.href='${pageContext.request.contextPath}/admin/payment/main'"
                 style="cursor:pointer;">
                <div class="stat-label">이번 달 매출</div>
                <div class="stat-value"><fmt:formatNumber value="${monthSales != null ? monthSales : 0}" pattern="#,###"/>원</div>
                <a href="${pageContext.request.contextPath}/admin/payment/main" class="plus-btn" onclick="event.stopPropagation()">+</a>
            </div>

            <div class="stat-card center">
                <div class="stat-label">등록 클래스</div>
                <div class="stat-value">${totalClass != null ? totalClass : 0}</div>
            </div>

            <div class="stat-card center">
                <div class="stat-label">승인 대기</div>
                <div class="stat-value">${pendingCount != null ? pendingCount : 0}</div>
            </div>

        </div>

        <%-- 우측 최근 결제 내역 --%>
        <div class="dash-middle">
            <div class="dash-section-header">
                <span class="dash-section-title">최근 결제 내역</span>
                <a href="${pageContext.request.contextPath}/admin/payment/main" class="btn btn-ghost btn-sm">+</a>
            </div>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>회원명</th><th>클래스명</th><th>금액</th><th>결제수단</th><th>결제일시</th><th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pay" items="${recentPayList}">
                        <tr>
                            <td>${pay.user_id}</td>
                            <td>${pay.pay_goods}</td>
                            <td><fmt:formatNumber value="${pay.pay_amount}" pattern="#,###"/>원</td>
                            <td>${pay.pay_method}</td>
                            <td style="font-size:11px;color:#888;">${pay.pay_date}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${pay.pay_status == 1}"><span class="badge badge-green">결제완료</span></c:when>
                                    <c:when test="${pay.pay_status == -1}"><span class="badge badge-red">결제취소</span></c:when>
                                    <c:otherwise><span class="badge badge-gray">결제대기</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

    <%-- 하단 2열 --%>
    <div class="dash-bottom">

        <%-- 호스트 권한 요청 --%>
        <div class="dash-section">
            <div class="dash-section-header">
                <span class="dash-section-title">호스트 권한 요청</span>
                <a href="${pageContext.request.contextPath}/admin/host/list" class="btn btn-ghost btn-sm">+</a>
            </div>
            <c:choose>
                <c:when test="${not empty hostRequestList}">
                    <c:forEach var="req" items="${hostRequestList}">
                        <div class="dash-row">
                            <span style="font-weight:600;">${req.userName}</span>
                            <span style="color:#888;">${req.userEmail}</span>
                            <span style="color:#aaa;font-size:11px;">${req.userJoinDate}</span>
                            <div style="display:flex;gap:6px;">
                                <button class="btn btn-black btn-sm" onclick="setRole('${req.userId}', 1)">승인</button>
                                <button class="btn btn-ghost btn-sm" onclick="setRole('${req.userId}', 0)">거절</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;color:#aaa;padding:20px;font-size:13px;">요청이 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- 클래스 등록 요청 --%>
        <div class="dash-section">
            <div class="dash-section-header">
                <span class="dash-section-title">클래스 등록 요청</span>
                <a href="${pageContext.request.contextPath}/admin/class/list" class="btn btn-ghost btn-sm">+</a>
            </div>
            <c:choose>
                <c:when test="${not empty classRequestList}">
                    <c:forEach var="cls" items="${classRequestList}">
                        <div class="dash-row">
                            <span style="font-weight:600;">${cls.cls_title}</span>
                            <span style="color:#888;">${cls.user_name}</span>
                            <span style="color:#aaa;font-size:11px;">${cls.cls_reg_date}</span>
                            <div style="display:flex;gap:6px;">
                                <button class="btn btn-black btn-sm" onclick="approveClass(${cls.class_id})">승인</button>
                                <button class="btn btn-ghost btn-sm" onclick="rejectClass(${cls.class_id})">거절</button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;color:#aaa;padding:20px;font-size:13px;">요청이 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</div>
</div>

<script>
function approveClass(id) {
    showConfirm('승인하시겠습니까?', function() {
        ajaxRequest('${pageContext.request.contextPath}/admin/class/approve',
            {classIds: id}, 'POST',
            function(res) { if (res.success) location.reload(); }
        );
    });
}
function rejectClass(id) {
    showConfirm('거절하시겠습니까?', function() {
        ajaxRequest('${pageContext.request.contextPath}/admin/class/reject',
            {classIds: id}, 'POST',
            function(res) { if (res.success) location.reload(); }
        );
    });
}
</script>