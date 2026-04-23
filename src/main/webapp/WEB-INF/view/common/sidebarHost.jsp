<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${loginUser.userRole >= 1}">
<aside class="sidebar-host">
    <div class="sidebar-title">강사 메뉴</div>
    <ul>
        <li><a href="${pageContext.request.contextPath}/mypage/instructor">강사 홈</a></li>
        <li><a href="${pageContext.request.contextPath}/host/class/list">내 강의</a></li>
        <li><a href="${pageContext.request.contextPath}/host/class/write">강의 등록</a></li>
        <li><a href="${pageContext.request.contextPath}/mypage/instructor/editInfo">정보 수정</a></li>
    </ul>
</aside>
</c:if>
