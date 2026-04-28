<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div style="font-size:12px;color:#e63946;margin-bottom:8px;">${st.settle_date}</div>
    
    <h2 style="font-size:22px;font-weight:700;margin-bottom:8px;">정산 금액: ${st.pay_amount}원</h2>
    
    <div style="font-size:13px;color:#888;display:flex;gap:12px;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid #eee;">
        <span>작성자: 관리자</span>
        </div>

    <div style="min-height:200px;line-height:1.8;font-size:14px;color:#333;margin-bottom:24px;">
        ${st.settle_content}
    </div>

    <c:if test="${sessionScope.loginUser.user_id == st.user_id}">
        <div style="text-align:right;margin-bottom:24px;display:flex;justify-content:flex-end;gap:8px;">
            <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/form?id=${st.settle_id}" class="btn btn-black btn-sm">수정</a>
            <button class="btn btn-ghost btn-sm" onclick="doDelete(${st.settle_id})">삭제</button>
        </div>
    </c:if>

    <div class="post-nav">
        <c:if test="${not empty prevPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8743; 이전글</span>
                <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/detail?id=${prevPost.settle_id}">이전 정산내역 보기</a>
            </div>
        </c:if>
        <c:if test="${not empty nextPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8744; 다음글</span>
                <a href="${pageContext.request.contextPath}/mypage/instructor/settlement/detail?id=${nextPost.settle_id}">다음 정산내역 보기</a>
            </div>
        </c:if>
    </div>

    <div style="text-align:center;margin-top:32px;">
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="btn btn-black btn-lg" style="min-width:120px;">목록</a>
    </div>

</div>
</main>
<script>
// 자바스크립트 파라미터 변수명도 settle_id 로 맞춤!
function doDelete(id){
    showConfirm('삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/mypage/instructor/settlement/delete',
            {settle_id: id}, 'POST',
            function(res){ if(res.success) location.href='${pageContext.request.contextPath}/mypage/instructor/settlement'; }
        );
    });
}
</script>