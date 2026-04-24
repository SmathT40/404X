<%-- =====================================================
     정산내역 목록 : /mypage/instructor/settlement
     ===================================================== --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage/instructor"            class="tab-item">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/myClass"    class="tab-item">내클래스</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="tab-item active">정산내역</a>
    </div>

    <h2 class="section-title">정산내역</h2>

    <table class="data-table">
        <thead>
            <tr><th>NO</th><th>정산금액</th><th>정산날짜</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty settlementList}">
                    <c:forEach var="st" items="${settlementList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/mypage/instructor/settlement/detail?id=${st.settleId}'" style="cursor:pointer;">
                            <td>${st.no}</td>
                            <td>${st.payAmount}</td>
                            <td>${st.settleDate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="3" style="text-align:center;color:#aaa;padding:30px;">정산내역이 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div style="text-align:right;margin-top:8px;">
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/form" class="btn btn-ghost btn-sm">글쓰기</a>
    </div>

    <jsp:include page="/WEB-INF/views/common/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}"/>
        <jsp:param name="totalPage"   value="${totalPage}"/>
        <jsp:param name="pageUrl"     value="/mypage/instructor/settlement?page="/>

</div>
</main>
