<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    공통 페이징 컴포넌트
    사용법:
    <jsp:include page="/WEB-INF/views/common/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}"/>
        <jsp:param name="totalPage"   value="${totalPage}"/>
        <jsp:param name="pageUrl"     value="/lecture/list?cat=JAVA&page="/>
--%>
<c:set var="cp"  value="${param.currentPage != null ? param.currentPage : 1}"/>
<c:set var="tp"  value="${param.totalPage   != null ? param.totalPage   : 1}"/>
<c:set var="url" value="${param.pageUrl}"/>

<div class="pagination">
    <%-- 첫 페이지 --%>
    <c:choose>
        <c:when test="${cp > 1}"><a href="${url}1">&laquo;</a></c:when>
        <c:otherwise><span style="opacity:.35">&laquo;</span></c:otherwise>
    </c:choose>

    <%-- 이전 페이지 --%>
    <c:choose>
        <c:when test="${cp > 1}"><a href="${url}${cp-1}">&lsaquo;</a></c:when>
        <c:otherwise><span style="opacity:.35">&lsaquo;</span></c:otherwise>
    </c:choose>

    <%-- 페이지 번호 (현재±2) --%>
    <c:forEach var="i" begin="${cp-2 > 1 ? cp-2 : 1}" end="${cp+2 < tp ? cp+2 : tp}">
        <c:choose>
            <c:when test="${i == cp}"><span class="active">${i}</span></c:when>
            <c:otherwise><a href="${url}${i}">${i}</a></c:otherwise>
        </c:choose>
    </c:forEach>

    <%-- 다음 페이지 --%>
    <c:choose>
        <c:when test="${cp < tp}"><a href="${url}${cp+1}">&rsaquo;</a></c:when>
        <c:otherwise><span style="opacity:.35">&rsaquo;</span></c:otherwise>
    </c:choose>

    <%-- 마지막 페이지 --%>
    <c:choose>
        <c:when test="${cp < tp}"><a href="${url}${tp}">&raquo;</a></c:when>
        <c:otherwise><span style="opacity:.35">&raquo;</span></c:otherwise>
    </c:choose>
</div>
