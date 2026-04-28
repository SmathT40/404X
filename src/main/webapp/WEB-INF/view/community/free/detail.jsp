<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>게시글 상세 - 404 X CLUB</title>

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

    <c:if test="${sessionScope.loginUser.user_id == board.user_id}">
        <div style="display:flex;justify-content:flex-end;gap:8px;margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/community/board/form?boardid=1&board_no=${board.board_no}"
               class="btn btn-black btn-sm">수정</a>
            <button class="btn btn-ghost btn-sm" onclick="doDelete(${board.board_no})">삭제</button>
        </div>
    </c:if>

    <div class="comment-section">
        <div class="comment-title">댓글</div>
        <c:if test="${not empty sessionScope.loginUser}">
            <div class="comment-write">
                <textarea id="cmtContent" class="form-control" placeholder="댓글 내용을 입력해주세요."
                          style="height:80px;resize:none;"></textarea>
                <div class="comment-write-actions">
                    <%-- 비공개 체크박스 추가 --%>
                    <label class="radio-label" style="font-size:12px;">
                        <input type="checkbox" id="cmtPrivate"> 비공개
                    </label>
                    <button class="btn btn-black btn-sm" onclick="submitComment()">등록</button>
                </div>
            </div>
        </c:if>

        <div id="replyList">
            <c:forEach var="cmt" items="${replyList}">
                <div class="comment-item">
                    <div style="flex:1;">
                        <div class="comment-meta">
                            <span class="comment-name">${cmt.user_name}</span>
                            <span>${cmt.cls_reply_reg_date}</span>
                        </div>
                        <div class="comment-content">
                            <c:choose>
                                <c:when test="${cmt.cls_reply_private == 1}">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.user_id eq cmt.user_id || sessionScope.loginUser.user_role >= 1}">
                                            <span style="color:#333;">🔒 ${cmt.cls_reply_content}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:#999;font-style:italic;">🔒 비공개 댓글입니다. 작성자와 강사만 볼 수 있습니다.</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    ${cmt.cls_reply_content}
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="comment-actions-row">
                            <c:if test="${cmt.cls_reply_private == 0 || (sessionScope.loginUser.user_id eq cmt.user_id || sessionScope.loginUser.user_role >= 1)}">
                                <span onclick="toggleReply(${cmt.cls_reply_no})">&#128172; 댓글달기</span>
                            </c:if>
                            <c:if test="${sessionScope.loginUser.user_id eq cmt.user_id || sessionScope.loginUser.user_role >= 1}">
                                <span onclick="deleteCmt(${cmt.cls_reply_no})">삭제</span>
                            </c:if>
                        </div>
                        <div id="reply-${cmt.cls_reply_no}" style="display:none;margin-top:8px;">
                            <textarea class="form-control" placeholder="댓글 내용을 입력해주세요." style="height:60px;resize:none;"></textarea>
                            <div style="text-align:right;margin-top:4px;">
                                <button class="btn btn-black btn-sm" onclick="submitReply(${cmt.cls_reply_no}, this)">등록</button>
                            </div>
                        </div>
                        <c:forEach var="reply" items="${cmt.replyList}">
                            <div class="reply-item">
                                <div class="comment-meta">
                                    <span class="comment-name">${reply.user_name}</span>
                                    <span>${reply.cls_reply_reg_date}</span>
                                </div>
                                <c:choose>
                                    <c:when test="${cmt.cls_reply_private == 1}">
                                        <c:choose>
                                            <c:when test="${sessionScope.loginUser.user_id eq cmt.user_id || sessionScope.loginUser.user_id eq reply.user_id || sessionScope.loginUser.user_role >= 1}">
                                                <span style="color:#333;">🔒 ${reply.cls_reply_content}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#999;font-style:italic;font-size:13px;">🔒비공개 댓글입니다.</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        ${reply.cls_reply_content}
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${sessionScope.loginUser.user_id eq reply.user_id || sessionScope.loginUser.user_role >= 1}">
                                    <span onclick="deleteCmt(${reply.cls_reply_no})" style="cursor:pointer;font-size:12px;color:#aaa;"><br>삭제</span>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="post-nav">
        <c:if test="${not empty prevPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8743; 이전글</span>
                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=1&board_no=${prevPost.board_no}">
                    ${prevPost.board_title}
                </a>
            </div>
        </c:if>
        <c:if test="${not empty nextPost}">
            <div class="post-nav-item">
                <span class="nav-label">&#8744; 다음글</span>
                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=1&board_no=${nextPost.board_no}">
                    ${nextPost.board_title}
                </a>
            </div>
        </c:if>
    </div>

    <div style="text-align:center;margin-top:32px;">
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=1"
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
        form.append('<input type="hidden" name="boardid" value="1">');
        form.append('<input type="hidden" name="board_no" value="' + id + '">');
        $('body').append(form);
        form.submit();
    });
}

function submitComment(){
    var content = $('#cmtContent').val().trim();
    var isPrivate = $('#cmtPrivate').is(':checked') ? 1 : 0; // 비공개 추가
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    $.ajax({
        url: '${pageContext.request.contextPath}/class/comment/insert',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            board_no: board_no,
            cls_reply_content: content,
            cls_reply_private: isPrivate,
            cls_parent_id: null
        }),
        success: function(res){
            if(res.success) location.reload();
            else showAlert('등록에 실패했습니다.');
        },
        error: function(){ showAlert('서버 통신 오류가 발생했습니다.'); }
    });
}

function submitReply(parentId, btn){
    var content = $(btn).closest('div').prev('textarea').val().trim();
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    $.ajax({
        url: '${pageContext.request.contextPath}/class/comment/insert',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            board_no: board_no,
            cls_reply_content: content,
            cls_parent_id: parentId,
            cls_reply_private: 0
        }),
        success: function(res){ if(res.success) location.reload(); }
    });
}

function deleteCmt(id){
    showConfirm('삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/class/comment/delete',
            {cls_reply_no: id}, 'POST',
            function(res){ if(res.success) location.reload(); }
        );
    });
}

function toggleReply(id){ $('#reply-' + id).toggle(); }
</script>