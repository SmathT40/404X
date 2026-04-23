<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div style="text-align:center;padding:80px 20px;">

    <div style="font-size:80px;font-weight:900;color:#eee;line-height:1;margin-bottom:16px;">
        <c:choose>
            <c:when test="${errorCode == 403}">403</c:when>
            <c:when test="${errorCode == 404}">404</c:when>
            <c:otherwise>500</c:otherwise>
        </c:choose>
    </div>

    <div style="font-size:20px;font-weight:700;margin-bottom:10px;">
        <c:choose>
            <c:when test="${errorCode == 403}">접근 권한이 없습니다.</c:when>
            <c:when test="${errorCode == 404}">페이지를 찾을 수 없습니다.</c:when>
            <c:otherwise>서버 오류가 발생했습니다.</c:otherwise>
        </c:choose>
    </div>

    <p style="font-size:14px;color:#888;margin-bottom:32px;">
        <c:choose>
            <c:when test="${errorCode == 403}">
                이 페이지에 접근할 수 있는 권한이 없습니다.<br>
                로그인 후 다시 시도해주세요.
            </c:when>
            <c:when test="${errorCode == 404}">
                요청하신 페이지가 삭제되었거나 주소가 변경되었습니다.
            </c:when>
            <c:otherwise>
                일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.
            </c:otherwise>
        </c:choose>
    </p>

    <div style="display:flex;justify-content:center;gap:12px;">
        <a href="${pageContext.request.contextPath}/"
           class="btn btn-black btn-lg" style="min-width:140px;">메인으로</a>
        <a href="javascript:history.back()"
           class="btn btn-ghost btn-lg" style="min-width:140px;">이전 페이지</a>
    </div>

</div>
</main>

