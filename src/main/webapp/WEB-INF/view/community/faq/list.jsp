<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>FAQ - 404 X CLUB</title>

<head>
    <style>
        .faq-item { border:1px solid #eee;border-radius:8px;margin-bottom:10px;overflow:hidden; }
        .faq-question { display:flex;align-items:center;justify-content:space-between;padding:16px 20px;cursor:pointer;font-size:14px;font-weight:500;background:#fff;transition:background 0.15s; }
        .faq-question:hover { background:#fafafa; }
        .faq-question.open { background:#f5f5f5; }
        .faq-question .q-label { color:#e63946;font-weight:700;margin-right:10px; }
        .faq-toggle { font-size:18px;color:#aaa;transition:transform 0.2s; }
        .faq-answer { display:none;padding:16px 20px;font-size:13px;color:#555;line-height:1.8;background:#f9f9f9;border-top:1px solid #eee; }
    </style>
</head>

<main class="content-area">
<div class="container" style="max-width:900px;">

    <div class="tab-bar" style="justify-content:center;margin-bottom:28px;">
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=3" class="tab-item">문의사항</a>
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=2" class="tab-item active">FAQ</a>
    </div>
    
    <%-- 0428 관리자만 글쓰기 버튼 표시 --%>
    <c:if test="${sessionScope.loginUser.user_role == 2}">
        <div style="text-align:right;margin-bottom:16px;">
            <a href="${pageContext.request.contextPath}/community/board/form?boardid=2" class="btn btn-black btn-sm">글쓰기</a>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty faqList}">
            <c:forEach var="faq" items="${faqList}">
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleFaq(this)">
                        <span><span class="q-label">Q.</span>&nbsp;${faq.board_title}</span>
                        <span class="faq-toggle">+</span>
                    </div>
                    <div class="faq-answer">${faq.board_content}</div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div style="text-align:center;color:#aaa;padding:40px;">등록된 FAQ가 없습니다.</div>
        </c:otherwise>
    </c:choose>

</div>
</main>

<script>
function toggleFaq(el){
    var $q = $(el);
    var $a = $q.next('.faq-answer');
    var isOpen = $q.hasClass('open');
    $('.faq-question').removeClass('open').find('.faq-toggle').text('+');
    $('.faq-answer').slideUp(200);
    if(!isOpen){
        $q.addClass('open').find('.faq-toggle').text('−');
        $a.slideDown(200);
    }
}
</script>