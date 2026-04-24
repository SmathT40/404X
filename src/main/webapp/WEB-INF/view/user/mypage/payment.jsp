<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>결제 내역 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage"           class="tab-item">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/classroom" class="tab-item">내강의실</a>
        <a href="${pageContext.request.contextPath}/mypage/myPost"    class="tab-item">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/payment"   class="tab-item active">결제내역</a>
    </div>

    <h2 class="section-title">결제내역</h2>

    <table class="data-table">
        <thead>
            <tr><th>강의번호</th><th>강의제목</th><th>결제금액</th><th>결제날짜</th><th>결제상태</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty payList}">
                    <c:forEach var="pay" items="${payList}">
                        <tr>
                            <td>${pay.payNo}</td>
                            <td>${pay.title}</td>
                            <td><fmt:formatNumber value="${pay.payAmount}" pattern="#,###"/>원</td>
                            <td>${pay.payDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${pay.payStatus == 1}"><span class="badge badge-blue">결제성공</span></c:when>
                                    <c:when test="${pay.payStatus == 2}"><span class="badge badge-red">결제취소</span></c:when>
                                    <c:otherwise><span class="badge badge-gray">${pay.status}</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="5" style="text-align:center;color:#aaa;padding:30px;">결제내역이 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <jsp:include page="/WEB-INF/view/common/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}"/>
        <jsp:param name="totalPage"   value="${totalPage}"/>
        <jsp:param name="pageUrl"     value="/mypage/payment?page="/>
	</jsp:include>
</div>
</main>
