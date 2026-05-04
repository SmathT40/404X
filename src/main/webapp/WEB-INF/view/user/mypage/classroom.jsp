<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>내 강의실 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
/* 1. 테이블 넓이 고정 및 레이아웃 설정 */
.data-table {
    width: 100%;
    table-layout: fixed; /* 컬럼 너비 고정의 핵심 */
    border-collapse: collapse;
}

/* 컬럼별 비율 설정 (필요에 따라 % 조정) */
.data-table th:nth-child(1) { width: 80px; }  /* 강의번호 */
.data-table th:nth-child(2) { width: auto; }  /* 강의제목 (유동적) */
.data-table th:nth-child(3) { width: 100px; } /* 차시 */
.data-table th:nth-child(4) { width: 100px; } /* 진도율 */
.data-table th:nth-child(5) { width: 120px; } /* 강사명 */
.data-table th:nth-child(6) { width: 130px; } /* 강의만료일 */

.data-table td {
    padding: 12px 8px;
    text-align: center;
    white-space: nowrap;      /* 텍스트 줄바꿈 방지 */
    overflow: hidden;         /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis;  /* 말줄임표(...) 표시 */
}
.data-table th {
	text-align: center;
}

/* 2. 만료된 강의 영역 흐리게 처리 */
.expired-section {
    opacity: 0.6;             /* 투명도 조절 */
    filter: grayscale(80%);    /* 회색톤 추가 (더 흐린 느낌) */
    transition: opacity 0.3s;
}

/* 마우스 올렸을 때만 살짝 선명하게 (선택 사항) */
.expired-section:hover {
    opacity: 0.8;
}

.expired-section .data-table {
    background-color: #f9f9f9; /* 배경색을 살짝 깔아서 차별화 */
}
</style>
<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage/index"           class="tab-item">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/classroom" class="tab-item active">내강의실</a>
        <a href="${pageContext.request.contextPath}/mypage/myPost"    class="tab-item">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/payment"   class="tab-item">결제내역</a>
    </div>

    <h2 class="section-title">내강의실</h2>
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
    <%-- 수강중인 강의 --%>
    <div style="margin-bottom:40px;">
        <div style="font-weight:600;margin-bottom:14px;padding-bottom:8px;border-bottom:1px solid #eee;">수강중인 강의</div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>강의번호</th><th>강의명</th><th>차시</th><th>진도율</th><th>강사명</th><th>강의만료일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myclassList}">
                        <c:forEach var="cls" items="${myclassList}">
                        <c:if test="${cls.cls_state_status == 1 && cls.cls_end_date >= today}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/class/leclist?class_id=${cls.class_id}'" style="cursor:pointer;">
                                <td>${cls.class_id}</td>
                                <td>${cls.cls_title}</td>
                                <td>${cls.complete_cnt} / ${cls.total_cnt}</td>
                                <td>${cls.progress}%</td>
                                <td>${cls.user_name}</td>
                                <td>${cls.cls_end_date}</td>
                            </tr>
                        </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">수강중인 강의가 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
<%-- 0429 pagination 삭제 --%>
    </div>

    <%-- 만료된 강의 --%>
    <div class="expired-section">
        <div style="font-weight:600;margin-bottom:14px;padding-bottom:8px;border-bottom:1px solid #eee;">만료된 강의</div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>강의번호</th><th>강의명</th><th>차시</th><th>진도율</th><th>강사명</th><th>강의만료일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myclassList}">
                        <c:forEach var="cls" items="${myclassList}">
                        <c:if test="${cls.cls_end_date < today || cls.cls_state_status != 1}">
                            <tr>
                                <td>${cls.class_id}</td>
                                <td>${cls.cls_title}</td>
                                <td>${cls.complete_cnt} / ${cls.total_cnt}</td>
                                <td>${cls.progress}%</td>
                                <td>${cls.user_name}</td>
                                <td>${cls.cls_end_date}</td>
                            </tr>
                        </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">만료된 강의가 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
<%-- 0429 pagination 삭제 --%>
    </div>

</div>
</main>
