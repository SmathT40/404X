<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>결제 관리 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<div class="admin-content">

    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/admin/payment/main"
           class="tab-item ${activeTab == 'main' ? 'active' : 'inactive'}">결제관리</a>
        <a href="${pageContext.request.contextPath}/admin/payment/approval"
           class="tab-item ${activeTab == 'approval' ? 'active' : 'inactive'}">환불승인</a>
        <a href="${pageContext.request.contextPath}/admin/payment/history"
           class="tab-item ${activeTab == 'history' ? 'active' : 'inactive'}">전체 결제내역</a>
    </div>

    <div class="admin-page">

        <c:choose>
            <%-- 결제관리 메인 탭 --%>
            <c:when test="${activeTab == 'main'}">
                <div class="stat-grid stat-grid-5">
                    <div class="stat-card accent">
                        <div class="stat-label">이번 달 매출</div>
                        <div class="stat-value"><fmt:formatNumber value="${monthSales}" pattern="#,###"/>원</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">카카오페이</div>
                        <div class="stat-value" style="font-size:18px;"><fmt:formatNumber value="${kakaoPayTotal}" pattern="#,###"/>원</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">네이버페이</div>
                        <div class="stat-value" style="font-size:18px;"></div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">무통장입금</div>
                        <div class="stat-value" style="font-size:18px;"></div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-label">환불완료</div>
                        <div class="stat-value" style="font-size:18px;">${refundCount}</div>
                    </div>
                </div>

                <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
                    <div class="admin-section">
                        <div class="admin-section-header">
                            <span class="admin-section-title">결제 환불 요청건</span>
                            <a href="${pageContext.request.contextPath}/admin/payment/approval" class="btn btn-ghost btn-sm">+</a>
                        </div>
                        <c:choose>
                            <c:when test="${not empty pendingList}">
                                <c:forEach var="pay" items="${pendingList}">
                                    <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 0;border-bottom:1px solid #f5f5f5;font-size:12px;gap:6px;">
                                        <span>${pay.user_id}</span>
                                        <span style="color:#888;flex:1;text-align:center;">${pay.pay_goods}</span>
                                        <span><fmt:formatNumber value="${pay.pay_amount}" pattern="#,###"/>원</span>
                                        <span style="color:#aaa;">${pay.pay_date}</span>
                                        <button class="btn btn-black btn-sm" onclick="refundOne(${pay.pay_no})">환불</button>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align:center;color:#aaa;padding:20px;">환불 요청건이 없습니다.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="admin-section">
                        <div class="admin-section-header">
                            <span class="admin-section-title">전체 결제내역</span>
                            <a href="${pageContext.request.contextPath}/admin/payment/history" class="btn btn-ghost btn-sm">+</a>
                        </div>
                        <c:forEach var="pay" items="${recentPayList}">
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:9px 0;border-bottom:1px solid #f5f5f5;font-size:12px;gap:6px;">
                                <span>${pay.user_id}</span>
                                <span style="color:#888;flex:1;text-align:center;">${pay.pay_goods}</span>
                                <span><fmt:formatNumber value="${pay.pay_amount}" pattern="#,###"/>원</span>
                                <span style="color:#aaa;">${pay.pay_date}</span>
                                <c:choose>
                                    <c:when test="${pay.pay_status == 1}"><span class="badge badge-green">결제완료</span></c:when>
                                    <c:when test="${pay.pay_status == -1}"><span class="badge badge-red">결제취소</span></c:when>
                                    <c:otherwise><span class="badge badge-gray">결제대기</span></c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:when>

            <%-- 환불승인 탭 --%>
            <c:when test="${activeTab == 'approval'}">
                <div class="search-bar">
                    <input type="text" class="search-input" id="keyword" placeholder="주문번호로 검색..." value="${param.keyword}">
                    <button class="search-btn" onclick="doSearch('approval')">검색</button>
                </div>
                <div class="admin-actions-row">
                    <span class="admin-page-title">환불승인</span>
                    <div style="display:flex;gap:8px;">
                        <button class="btn btn-black btn-sm" onclick="refundSelected()">선택환불</button>
                    </div>
                </div>
                <div class="admin-section" style="padding:0;">
                    <table class="data-table" id="payTable">
                        <thead>
                            <tr>
                                <th><input type="checkbox" class="chk-all"></th>
                                <th>주문번호</th>
                                <th>이름</th>
                                <th>클래스명</th>
                                <th>가격</th>
                                <th>주문일</th>
                                <th>환불여부</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pay" items="${payList}">
                                <tr>
                                    <td><input type="checkbox" class="chk-item" value="${pay.pay_no}"></td>
                                    <td style="font-size:11px;color:#888;">${pay.pay_uid}</td>
                                    <td>${pay.user_id}</td>
                                    <td>${pay.pay_goods}</td>
                                    <td><fmt:formatNumber value="${pay.pay_amount}" pattern="#,###"/>원</td>
                                    <td>${pay.pay_date}</td>
                                    <td style="display:flex;gap:6px;">
                                        <c:choose>
                                            <c:when test="${pay.pay_status == -1}">
                                                <button class="btn btn-ghost btn-sm" disabled>환불완료</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-black btn-sm" onclick="refundOne(${pay.pay_no})">환불</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <jsp:include page="/WEB-INF/view/common/pagination.jsp">
                    <jsp:param name="currentPage" value="${currentPage}"/>
                    <jsp:param name="totalPage"   value="${totalPage}"/>
                    <jsp:param name="pageUrl"     value="/admin/payment/approval?page="/>
                </jsp:include>
            </c:when>

            <%-- 전체 결제내역 탭 --%>
            <c:otherwise>
                <div class="search-bar">
                    <input type="text" class="search-input" id="keyword" placeholder="강의명으로 검색..." value="${param.keyword}">
                    <button class="search-btn" onclick="doSearch('history')">검색</button>
                </div>
                <div class="admin-page-title" style="margin-bottom:12px;">전체 결제내역</div>
                <div class="admin-section" style="padding:0;">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>주문번호</th>
                                <th>이름</th>
                                <th>클래스명</th>
                                <th>가격</th>
                                <th>날짜</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pay" items="${payList}">
                                <tr>
                                    <td style="font-size:11px;color:#888;">${pay.pay_uid}</td>
                                    <td>${pay.user_id}</td>
                                    <td>${pay.pay_goods}</td>
                                    <td><fmt:formatNumber value="${pay.pay_amount}" pattern="#,###"/>원</td>
                                    <td>${pay.pay_date}</td>
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
                <jsp:include page="/WEB-INF/view/common/pagination.jsp">
                    <jsp:param name="currentPage" value="${currentPage}"/>
                    <jsp:param name="totalPage"   value="${totalPage}"/>
                    <jsp:param name="pageUrl"     value="/admin/payment/history?page="/>
                </jsp:include>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<script>
var ctx='${pageContext.request.contextPath}';
function doSearch(tab){ location.href=ctx+'/admin/payment/'+tab+'?keyword='+encodeURIComponent($('#keyword').val()); }

function refundOne(payNo){
    showConfirm('환불하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/payment/refund', {pay_no: payNo}, 'POST',
            function(res){
                if(res.success){
                    showAlert('환불이 완료되었습니다.', function(){ location.reload(); });
                } else {
                    showAlert(res.msg || '환불에 실패했습니다.');
                }
            }
        );
    });
}

function refundSelected(){
    var ids=[]; $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('환불할 항목을 선택해주세요.'); return; }
    showConfirm('선택 항목을 환불하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/payment/refundMulti', {pay_nos: ids.join(',')}, 'POST',
            function(res){
                if(res.success){
                    showAlert('환불이 완료되었습니다.', function(){ location.reload(); });
                } else {
                    showAlert(res.msg || '환불에 실패했습니다.');
                }
            }
        );
    });
}
</script>
