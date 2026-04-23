<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="gnb">
    <div class="gnb-inner">
        <a href="${pageContext.request.contextPath}/" class="logo">404 X CLUB</a>
        <ul class="gnb-menu">
            <li><a href="${pageContext.request.contextPath}/about">학원소개</a></li>
            <li><a href="${pageContext.request.contextPath}/instructor">강사소개</a></li>
            <li><a href="${pageContext.request.contextPath}/lecture/list">강의목록</a></li>
            <li class="has-sub">
                <a href="#">커뮤니티</a>
                <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/community/notice">공지사항</a></li>
                    <li><a href="${pageContext.request.contextPath}/community/free">자유게시판</a></li>
                </ul>
            </li>
            <li class="has-sub">
                <a href="#">학습지원</a>
                <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/community/inquiry">1:1문의</a></li>
                    <li><a href="${pageContext.request.contextPath}/community/faq">FAQ</a></li>
                </ul>
            </li>
        </ul>
        <div class="gnb-user">
            <c:choose>
                <c:when test="${not empty loginUser}">
                    <a href="${pageContext.request.contextPath}/mypage">마이페이지</a>
                    <c:if test="${loginUser.userRole >= 1}">
                        <a href="${pageContext.request.contextPath}/host/class/list">강사</a>
                    </c:if>
                    <c:if test="${loginUser.userRole == 2}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard">관리자</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/logout">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">로그인</a>
                    <a href="${pageContext.request.contextPath}/user/join">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
