<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 목록 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<main class="content-area">
<div class="container">

<%-- 1. 대분류 탭 --%>
<div class="lecture-cat-tab">
    <c:forEach var="cat" items="${categoryList}">
        <a href="${pageContext.request.contextPath}/class/list?cat=${cat.category_code}" 
           class="clstab-item ${currentCat == cat.category_code ? 'active' : ''}">
            ${cat.category_name}
        </a>
    </c:forEach>
</div>

<%-- 2. ★ 중분류(소분류) 버튼 영역 --%>
<div class="lecture-sub-tab">
    <c:if test="${not empty subCategoryList}">
        <c:forEach var="sub" items="${subCategoryList}">
            <%-- 대분류(cat)와 소분류(sub) 코드를 함께 유지하며 이동 --%>
            <a href="${pageContext.request.contextPath}/class/list?cat=${currentCat}&sub=${sub.category_code}" 
               class="sub-item ${currentSub == sub.category_code ? 'active' : ''}">
                ${sub.category_name}
            </a>
        </c:forEach>
    </c:if>
</div>

    <%-- 강의 카드 그리드 --%>
    <c:if test="${not empty featuredList}">
        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-bottom:32px;">
            <c:forEach var="cls" items="${featuredList}">
                <a href="${pageContext.request.contextPath}/class/detail?id=${cls.class_id}" class="card" style="display:block;">
                    <div style="background:#ddd;height:160px;border-radius:8px;margin-bottom:12px;overflow:hidden;">
                        <c:if test="${not empty cls.cls_thumbnail}">
                            <img src="${cls.cls_thumbnail}" style="width:100%;height:100%;object-fit:cover;">
                        </c:if>
                    </div>
                    <div style="font-size:12px;color:#888;">${cls.user_name}</div>
                    <div style="font-size:14px;font-weight:600;margin-top:4px;">${cls.cls_title}</div>
                </a>
            </c:forEach>
        </div>
    </c:if>

    <%-- 전체 목록 테이블 --%>
    <table class="data-table">
        <thead>
            <tr><th>NO</th><th>제목</th><th>강사명</th><th>등록일</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty classList}">
                    <c:forEach var="cls" items="${classList}" varStatus="status">
                        <tr onclick="location.href='${pageContext.request.contextPath}/class/detail?id=${cls.class_id}'" style="cursor:pointer;">
                            <td>${status.count}</td>
                            <td>${cls.cls_title}</td>
                            <td>${cls.user_name}</td>
                            <td><fmt:formatDate value="${cls.cls_reg_date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="4" style="text-align:center;color:#aaa;padding:30px;">등록된 강의가 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    <jsp:include page="/WEB-INF/view/common/pagination.jsp">
        <jsp:param name="currentPage" value="${currentPage}"/>
        <jsp:param name="totalPage"   value="${totalPage}"/>
        <jsp:param name="pageUrl"     value="/class/list?cat=${param.cat}&sub=${param.sub}&page="/>
    </jsp:include>

</div>
</main>
