<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ==============================
     사이트 헤더
     ============================== --%>
<header id="header">
    <div class="header-top">
        <%-- 로고 --%>
        <a href="${pageContext.request.contextPath}/" class="header-logo">404 X CLUB</a>

        <%-- 우측 유틸 메뉴: 로그인 여부에 따라 분기 --%>
        <div class="header-utils">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <%-- 로그인 상태 --%>
                    <a href="${pageContext.request.contextPath}/mypage/classroom">&#128218; 내강의실</a>
                    <a href="${pageContext.request.contextPath}/mypage">&#128100; 마이페이지</a>
                    <a href="${pageContext.request.contextPath}/cart">&#128722; 장바구니</a>
                    <a href="${pageContext.request.contextPath}/user/logout">&#128682; 로그아웃</a>
                </c:when>
                <c:otherwise>
                    <%-- 비로그인 상태 --%>
                    <a href="${pageContext.request.contextPath}/user/login">&#128275; 로그인</a>
                    <a href="${pageContext.request.contextPath}/user/join">&#128221; 회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- GNB 포함 --%>
</header>
