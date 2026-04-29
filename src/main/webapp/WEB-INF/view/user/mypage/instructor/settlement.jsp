<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            <tr>
                <th>NO</th>
                <th>정산명 (자동 생성)</th>
                <th>정산금액</th>
                <th>정산날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty settlementList}">
                    <c:forEach var="st" items="${settlementList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/mypage/instructor/settlement/detail?id=${st.settle_id}'" style="cursor:pointer;">
                            
                            <td>${st.settle_id}</td>
                            
                            <td style="text-align: left; padding-left: 15px;">
                                <fmt:formatDate value="${st.settle_date}" pattern="yyyy" var="year" />
                                <fmt:formatDate value="${st.settle_date}" pattern="MM" var="month" />
                                <span style="font-weight: 600; color: #333;">
                                    [${year}년 ${month}월분] 강사료 정산내역
                                </span>
                            </td>
                            
                            <td style="font-weight: bold; color: #2a9d8f;">
                                <fmt:formatNumber value="${st.pay_amount}" pattern="#,###" />원
                            </td>
                            
                            <td style="color: #666;">
                                <fmt:formatDate value="${st.settle_date}" pattern="yyyy-MM-dd" />
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                
                <c:otherwise>
                    <tr>
                        <td colspan="4" style="text-align:center; color:#aaa; padding:50px 0;">
                            정산 내역이 존재하지 않습니다.
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div style="text-align:right; margin-top:16px;">
    	<a href="${pageContext.request.contextPath}/mypage/instructor/settlement/form?target_id=${target_id}" class="btn btn-ghost btn-sm">정산내역 등록</a>
	</div>

    <jsp:include page="/WEB-INF/view/common/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}"/>
        <jsp:param name="totalPage"   value="${totalPage}"/>
        <jsp:param name="pageUrl"     value="/mypage/instructor/settlement?page="/>
    </jsp:include>

</div>
</main>