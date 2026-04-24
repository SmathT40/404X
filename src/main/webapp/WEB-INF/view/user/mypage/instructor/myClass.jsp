<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>내 강의 목록 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage/instructor"            class="tab-item">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/myClass"    class="tab-item active">내클래스</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="tab-item">정산내역</a>
    </div>

    <h2 class="section-title">내클래스</h2>

    <table class="data-table">
        <thead>
            <tr><th>클래스번호</th><th>클래스이름</th><th>작성게시판</th><th>작성날짜</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty myClassList}">
                    <c:forEach var="cls" items="${myClassList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/mypage/instructor/myClass/detail?id=${cls.classId}'" style="cursor:pointer;">
                            <td>${cls.clsNo}</td>
                            <td>${cls.clsTitle}</td>
                            <td>${cls.subject}</td>
                            <td>${cls.clsRegDate}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="4" style="text-align:center;color:#aaa;padding:30px;">등록된 클래스가 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <jsp:include page="/WEB-INF/views/common/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}"/>
        <jsp:param name="totalPage"   value="${totalPage}"/>
        <jsp:param name="pageUrl"     value="/mypage/instructor/myClass?page="/>

</div>
</main>
