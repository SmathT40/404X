<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>내 강의실 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage"           class="tab-item">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/classroom" class="tab-item active">내강의실</a>
        <a href="${pageContext.request.contextPath}/mypage/myPost"    class="tab-item">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/payment"   class="tab-item">결제내역</a>
    </div>

    <h2 class="section-title">내강의실</h2>

    <%-- 수강중인 강의 --%>
    <div style="margin-bottom:40px;">
        <div style="font-weight:600;margin-bottom:14px;padding-bottom:8px;border-bottom:1px solid #eee;">수강중인 강의</div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>강의번호</th><th>강의제목</th><th>차시</th><th>진도율</th><th>강사명</th><th>강의만료일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myclassList}">
                        <c:forEach var="cls" items="${myclassList}">
                        <c:if test="${cls.cls_state_status == 1}">
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
                        <tr><td colspan="5" style="text-align:center;color:#aaa;padding:30px;">수강중인 강의가 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${activePage}"/>
            <jsp:param name="totalPage"   value="${activeTotalPage}"/>
            <jsp:param name="pageUrl"     value="/mypage/classroom?type=active&page="/>
        </jsp:include>
    </div>

    <%-- 만료된 강의 --%>
    <div>
        <div style="font-weight:600;margin-bottom:14px;padding-bottom:8px;border-bottom:1px solid #eee;">만료된 강의</div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>강의번호</th><th>강의제목</th><th>진행률</th><th>강사명</th><th>강의만료일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myclassList}">
                        <c:forEach var="cls" items="${myclassList}">
                        <c:if test="${cls.cls_state_status == 0}">
                            <tr>
                                <td>${cls.class_id}</td>
                                <td>${cls.cls_title}</td>
                                <td>100%</td>
                                <td>${cls.user_name}</td>
                                <td>${cls.cls_end_date}</td>
                            </tr>
                        </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5" style="text-align:center;color:#aaa;padding:30px;">만료된 강의가 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${expiredPage}"/>
            <jsp:param name="totalPage"   value="${expiredTotalPage}"/>
            <jsp:param name="pageUrl"     value="/mypage/classroom?type=expired&page="/>
        </jsp:include>
    </div>

</div>
</main>
