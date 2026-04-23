<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div style="font-size:12px;color:#e63946;margin-bottom:8px;">${settleInfo.clsRegDate}</div>
    <h2 style="font-size:22px;font-weight:700;margin-bottom:8px;">${settleInfo.clsTitle}</h2>
    <div style="font-size:13px;color:#888;display:flex;gap:12px;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid #eee;">
        <span>${settleInfo.authorName}</span>
        <span>&#128065; ${settleInfo.boardCnt}</span>
    </div>

    <%-- 본문 --%>
    <div style="min-height:200px;line-height:1.8;font-size:14px;color:#333;margin-bottom:24px;">
        ${settleInfo.clsContent}
    </div>

    <%-- 첨부 이미지 --%>
    <c:if test="${not empty settleInfo.attachImgList}">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:24px;">
            <c:forEach var="img" items="${settleInfo.attachImgList}">
                <div style="background:#eee;border-radius:8px;height:200px;overflow:hidden;">
                    <img src="${img}" style="width:100%;height:100%;object-fit:cover;">
                </div>
            </c:forEach>
        </div>
    </c:if>

    <%-- 수정/삭제 버튼 (본인만) --%>
    <c:if test="${sessionScope.loginUser.userId == settleInfo.userId}">
        <div style="text-align:right;margin-bottom:24px;display:flex;justify-content:flex-end;gap:8px;">
            <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/form?id=${settleInfo.settleId}" class="btn btn-black btn-sm">수정</a>
            <button class="btn btn-ghost btn-sm" onclick="doDelete(${settleInfo.settleId})">삭제</button>
        </div>
    </c:if>

    <%-- 이전글/다음글 --%>
    <div class="post-nav">
        <c:if test="${not empty prevPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8743; 이전글</span>
                <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/detail?id=${prevPost.settleId}">${prevPost.clsTitle}</a>
            </div>
        </c:if>
        <c:if test="${not empty nextPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8744; 다음글</span>
                <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/detail?id=${nextPost.settleId}">${nextPost.clsTitle}</a>
            </div>
        </c:if>
    </div>

    <div style="text-align:center;margin-top:32px;">
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="btn btn-black btn-lg" style="min-width:120px;">목록</a>
    </div>

</div>
</main>
<script>
function doDelete(id){
    showConfirm('삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/mypage/instructor/settlement/delete',
            {settleId: id}, 'POST',
            function(res){ if(res.success) location.href='${pageContext.request.contextPath}/mypage/instructor/settlement'; }
        );
    });
}
</script>
