<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>문의 상세 - 404 X CLUB</title>

<head>
    <style>
        .comment-section { margin-top:40px;border-top:2px solid #eee;padding-top:20px; }
        .comment-title { font-size:15px;font-weight:600;margin-bottom:16px; }
    </style>
</head>

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

    <c:if test="${not empty board.board_file_path}">
        <div style="margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/resources/upload/file/${board.fileurl}"
               target="_blank">첨부파일: ${board.board_file_path}</a>
        </div>
    </c:if>

    <c:if test="${sessionScope.loginUser.user_id == board.user_id}">
        <div style="display:flex;justify-content:flex-end;gap:8px;margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/community/board/form?boardid=3&board_no=${board.board_no}"
               class="btn btn-black btn-sm">수정</a>
            <button class="btn btn-ghost btn-sm" onclick="doDelete(${board.board_no})">삭제</button>
        </div>
    </c:if>

    <div class="comment-section">
        <div class="comment-title">댓글 (관리자 답변)</div>
        <c:if test="${not empty sessionScope.loginUser}">
            <div class="comment-write">
                <textarea id="cmtContent" class="form-control"
                          placeholder="댓글 내용을 입력해주세요." style="height:80px;resize:none;"></textarea>
                <div class="comment-write-actions">
                    <button class="btn btn-black btn-sm" onclick="submitComment()">등록</button>
                </div>
            </div>
        </c:if>
        <c:forEach var="cmt" items="${replyList}">
            <div class="comment-item">
                <div style="flex:1;">
                    <div class="comment-meta">
                        <span class="comment-name">${cmt.user_id}</span>
                        <span>${cmt.reply_reg_date}</span>
                    </div>
                    <div class="comment-content">${cmt.reply_content}</div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="post-nav">
        <c:if test="${not empty prevPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8743; 이전글</span>
                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=3&board_no=${prevPost.board_no}">
                    ${prevPost.board_title}
                </a>
            </div>
        </c:if>
        <c:if test="${not empty nextPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8744; 다음글</span>
                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=3&board_no=${nextPost.board_no}">
                    ${nextPost.board_title}
                </a>
            </div>
        </c:if>
    </div>

    <div style="text-align:center;margin-top:32px;">
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=3"
           class="btn btn-black btn-lg" style="min-width:120px;">목록</a>
    </div>

</div>
</main>

<script>
var board_no = ${board.board_no};

function doDelete(id){
    showConfirm('삭제하시겠습니까?', function(){
        var form = $('<form method="post"></form>');
        form.attr('action', '${pageContext.request.contextPath}/community/board/delete');
        form.append('<input type="hidden" name="boardid" value="3">');
        form.append('<input type="hidden" name="board_no" value="' + id + '">');
        $('body').append(form);
        form.submit();
    });
}

function submitComment(){
    var content = $('#cmtContent').val().trim();
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/community/board/comment/insert',
        {board_no: board_no, reply_content: content}, 'POST',
        function(res){ if(res.success) location.reload(); });
}
</script>