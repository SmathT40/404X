<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>공지사항 상세 - 404 X CLUB</title>

<main class="content-area">
<div class="user-content" style="max-width:860px;">

    <div style="font-size:12px;color:#e63946;margin-bottom:8px;">${board.board_reg_date}</div>
    <h2 style="font-size:22px;font-weight:700;margin-bottom:8px;">${board.board_title}</h2>
    <div style="font-size:13px;color:#888;display:flex;gap:12px;
                margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid #eee;">
        <span>${board.user_id}</span>
        <span>&#128065; ${board.board_cnt}</span>
    </div>

    <div style="min-height:200px;line-height:1.9;font-size:14px;color:#333;margin-bottom:24px;">
        ${board.board_content}
    </div>

    <c:if test="${not empty board.fileurl}">
        <div style="margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/resources/upload/file/${board.fileurl}"
               target="_blank">첨부파일: ${board.fileurl}</a>
        </div>
    </c:if>


    <c:if test="${sessionScope.loginUser.user_role == 2}">

            <div style="display:flex;justify-content:flex-end;gap:8px;margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/community/board/form?boardid=0&board_no=${board.board_no}"
               class="btn btn-black btn-sm">수정</a>
            <button class="btn btn-ghost btn-sm" onclick="doDelete(${board.board_no})">삭제</button>
        </div>

        
    </c:if>


    <div class="post-nav">
        <c:if test="${not empty prevPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8743; 이전글</span>
                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=0&board_no=${prevPost.board_no}">
                    ${prevPost.board_title}
                </a>
            </div>
        </c:if>
        <c:if test="${not empty nextPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8744; 다음글</span>
                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=0&board_no=${nextPost.board_no}">
                    ${nextPost.board_title}
                </a>
            </div>
        </c:if>
    </div>

    <div style="text-align:center;margin-top:32px;">
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=0"
           class="btn btn-black btn-lg" style="min-width:120px;">목록</a>
    </div>

</div>
</main>

<script>
function doDelete(id){
    showConfirm('삭제하시겠습니까?', function(){
        ajaxRequest(
            '${pageContext.request.contextPath}/community/board/delete',
            {boardid: 0, board_no: id}, 'POST',
            function(res){
                if(res.success)
                    location.href='${pageContext.request.contextPath}/community/board/list?boardid=0';
            }
        );
    });
}
</script>