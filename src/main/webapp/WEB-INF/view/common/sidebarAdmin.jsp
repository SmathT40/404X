<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${loginUser.userRole == 2}">
<aside class="sidebar-admin">
    <div class="sidebar-title">관리자 메뉴</div>
    <ul>
        <li><a href="${pageContext.request.contextPath}/admin/dashboard">대시보드</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/member/list">회원관리</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/class/list">강의관리</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/board/list">게시판관리</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/payment/main">결제관리</a></li>
    </ul>
</aside>
</c:if>
