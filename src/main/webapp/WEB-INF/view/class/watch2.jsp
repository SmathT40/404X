<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>강의 수강 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<main class="content-area">
	<div class="user-content" style="max-width: 860px;">

		<h1 style="font-size: 22px; font-weight: 700; margin-bottom: 6px;">${lec.cls_title}</h1>
		<div
			style="font-size: 13px; color: #888; margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px solid #eee;">
			${lec.user_name} 강사 &nbsp;|&nbsp;${lec.lec_title}</div>

		<div style="font-size: 13px; color: #555; margin-bottom: 16px;">
			${lec.lec_content}</div>

		<%-- 동영상 플레이어 영역 --%>
		<div
			style="position: relative; width: 100%; padding-bottom: 56.25%; background: #222; border-radius: 8px; margin-bottom: 16px; overflow: hidden;">
			<iframe src="${lec.lec_url}"
				style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
				allowfullscreen> </iframe>
		</div>

		<%-- 수정/삭제 버튼 (강사 본인만) --%>
		<%--
		<c:if test="${sessionScope.loginUser.userRole >= 1}">
--%>
		<div
			style="text-align: right; margin-bottom: 24px; display: flex; justify-content: flex-end; gap: 8px;">
			<a
				href="${pageContext.request.contextPath}/host/class/lectureForm?id=${lec.lec_id}"
				class="btn btn-black btn-sm">수정</a>
			<button class="btn btn-ghost btn-sm" onclick="doDelete()">삭제</button>
		</div>
		<%--
		</c:if>
--%>
		<%-- 강의문의 댓글 --%>
		<div class="comment-section">
			<div class="comment-title">문의</div>

			<%-- 댓글 작성 --%>
			<%-- <c:if test="${not empty sessionScope.loginUser}"> --%>
			<div class="comment-write">
				<textarea id="cmtContent" class="form-control"
					placeholder="댓글 내용을 입력해주세요." style="height: 80px; resize: none;"></textarea>
				<div class="comment-write-actions">
					<label class="radio-label" style="font-size: 12px;"> <input
						type="checkbox" id="cmtPrivate"> 비공개
					</label>
					<button class="btn btn-black btn-sm" onclick="submitComment()">등록</button>
				</div>
			</div>
			<%--</c:if>--%>

			<%-- 댓글 목록 --%>
			<div id="replyList">
				<c:forEach var="cmt" items="${replyList}">
					<div class="comment-item">
						<div class="comment-avatar">
							<c:if test="${not empty cmt.profileImg}">
								<img src="${cmt.profileImg}">
							</c:if>
						</div>
						<div style="flex: 1;">
							<div class="comment-meta">
								<span class="comment-name">${cmt.userName}</span> <span>${cmt.regDate}</span>
							</div>
							<div class="comment-content">${cmt.content}</div>
							<div class="comment-actions-row">
								<span onclick="toggleReply(${cmt.cmtId})">&#128172; 댓글달기</span>
								<c:if test="${sessionScope.loginUser.userId == cmt.authorId}">
									<span onclick="deleteCmt(${cmt.cmtId})">삭제</span>
								</c:if>
							</div>
							<%-- 대댓글 입력창 (숨김) --%>
							<div id="reply-${cmt.cmtId}"
								style="display: none; margin-top: 8px;">
								<textarea class="form-control" placeholder="댓글 내용을 입력해주세요."
									style="height: 60px; resize: none;"></textarea>
								<div style="text-align: right; margin-top: 4px;">
									<button class="btn btn-black btn-sm"
										onclick="submitReply(${cmt.cmtId}, this)">등록</button>
								</div>
							</div>
							<%-- 대댓글 목록 --%>
							<c:forEach var="reply" items="${cmt.replyList}">
								<div class="reply-item">
									<div class="comment-meta">
										<span class="comment-name">${reply.userName}</span> <span>${reply.regDate}</span>
									</div>
									<div class="comment-content">${reply.content}</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<%-- 이전글/다음글 --%>
		<div class="post-nav">
			<c:if test="${not empty prevLecture}">
				<div class="post-nav-item">
					<span class="nav-label">&#8743; 이전글</span> <a
						href="${pageContext.request.contextPath}/lecture/watch?id=${prevLecture.lectureId}">${prevLecture.title}</a>
				</div>
			</c:if>
			<c:if test="${not empty nextLecture}">
				<div class="post-nav-item">
					<span class="nav-label">&#8744; 다음글</span> <a
						href="${pageContext.request.contextPath}/lecture/watch?id=${nextLecture.lectureId}">${nextLecture.title}</a>
				</div>
			</c:if>
		</div>
		<div style="text-align: center; margin-top: 32px;">
			<a href="${pageContext.request.contextPath}/class/leclist?class_id=${lec.class_id}"
				class="btn btn-black btn-lg" style="min-width: 120px;">목록</a>
		</div>
	</div>
</main>
<div style="position:fixed;bottom:0;left:0;right:0;background:#fff;border-top:1px solid #eee;padding:14px 24px;display:flex;justify-content:center;gap:16px;z-index:800;">
	<c:if test="${not empty prev}">
    	<a href="${pageContext.request.contextPath}/class/watch?class_id=${lec.class_id}&lec_id=${prev.lec_id}" class="btn btn-black btn-lg" style="min-width:100px;">이전</a>
    </c:if>
    <a href="${pageContext.request.contextPath}/class/leclist?class_id=${lec.class_id}" class="btn btn-ghost btn-lg" style="min-width:100px;">목록</a>
    <c:if test="${not empty next}">
    	<a href="${pageContext.request.contextPath}/class/watch?class_id=${lec.class_id}&lec_id=${next.lec_id}" class="btn btn-black btn-lg" style="min-width:100px;">다음</a>
	</c:if>
</div>

<div style="height:80px;"></div><%-- 하단 버튼 높이 보정 --%>

<script>
var lectureId = ${lec.lec_id};
function toggleReply(id){ $('#reply-' + id).toggle(); }
function submitComment(){
    var content = $('#cmtContent').val().trim();
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/lecture/comment/insert',
        {lectureId: lectureId, content: content}, 'POST',
        function(res){ if(res.success) location.reload(); });
}
function submitReply(parentId, btn){
    var content = $(btn).closest('div').prev('textarea').val().trim();
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/lecture/comment/insert',
        {lectureId: lectureId, content: content, parentId: parentId}, 'POST',
        function(res){ if(res.success) location.reload(); });
}
function deleteCmt(id){
    showConfirm('삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/lecture/comment/delete', {cmtId: id}, 'POST',
            function(res){ if(res.success) location.reload(); });
    });
}
function doDelete(){
    showConfirm('강의를 삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/host/class/deleteLecture', {lectureId: lectureId}, 'POST',
            function(res){ if(res.success) history.back(); });
    });
}
</script>
