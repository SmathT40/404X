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
				href="${pageContext.request.contextPath}/host/class/lecupdate?lec_id=${lec.lec_id}"
				class="btn btn-black btn-sm">수정</a>
			<button class="btn btn-ghost btn-sm" onclick="doDelete()">삭제</button>
		</div>
		<%--
		</c:if>
--%>

    <%-- 강의문의 댓글 --%>
    <div class="comment-section">
        <div class="comment-title">강의문의</div>

        <%-- 댓글 작성 --%>
        <%-- <c:if test="${not empty sessionScope.loginUser}"> --%>
            <div class="comment-write">
                <textarea id="cmtContent" class="form-control" placeholder="댓글 내용을 입력해주세요." style="height:80px;resize:none;"></textarea>
                <div class="comment-write-actions">
                    <label class="radio-label" style="font-size:12px;">
                        <input type="checkbox" id="cmtPrivate"> 비공개
                    </label>
                    <button class="btn btn-black btn-sm" onclick="submitComment()">등록</button>
                </div>
            </div>
        <%--</c:if>--%>

        <%-- 댓글 목록 --%>
        <div id="replyList">
            <c:forEach var="cmt" items="${replyList}">
                <div class="comment-item">
                <%--
                    <div class="comment-avatar">
                        <c:if test="${not empty cmt.profileImg}"><img src="${cmt.profileImg}"></c:if>
                    </div>
                --%>
                    <div style="flex:1;">
                        <div class="comment-meta">
                            <span class="comment-name">${cmt.user_name}</span>
                            <span>${cmt.cls_reply_reg_date}</span>
                        </div>
		<div class="comment-content">
		    <c:choose>
		        <%-- 비공개 일때 --%>
		        <c:when test="${cmt.cls_reply_private == 1}">
		            <%-- [권한 체크] 작성자 본인이거나 강사/관리자(레벨 1 이상)일 때만 내용 노출 --%>
		            <c:choose>
		                <c:when test="${loginUser.user_id eq cmt.user_id || loginUser.user_role >= 1}">
		                    <span style="color: #333;">🔒 ${cmt.cls_reply_content}</span>
		                </c:when>
		                <c:otherwise>
		                    <span style="color: #999; font-style: italic;">🔒 비공개 댓글입니다. 작성자와 강사만 볼 수 있습니다.</span>
		                </c:otherwise>
		            </c:choose>
		        </c:when>
		        <%-- 공개 댓글일 때 --%>
		        <c:otherwise>
		            ${cmt.cls_reply_content}
		        </c:otherwise>
		    </c:choose>
		</div>

						<div class="comment-actions-row">
						    <%-- 1. 댓글달기: 공개댓글이거나, 비공개라도 볼 권한이 있는 경우 --%>
						    <c:if test="${cmt.cls_reply_private == 0 || (loginUser.user_id eq cmt.user_id || loginUser.user_role >= 1)}">
						        <span onclick="toggleReply(${cmt.cls_reply_no})">&#128172; 댓글달기</span>
						    </c:if>
						
						    <%-- 2. 삭제: 작성자 본인이거나 강사/관리자일 경우 --%>
						    <c:if test="${loginUser.user_id eq cmt.user_id || loginUser.user_role >= 1}">
						        <span onclick="deleteCmt(${cmt.cls_reply_no})">삭제</span>
						    </c:if>
						</div>
                        <%-- 대댓글 입력창 (숨김) --%>
                        <div id="reply-${cmt.cls_reply_no}" style="display:none;margin-top:8px;">
                            <textarea class="form-control" placeholder="댓글 내용을 입력해주세요." style="height:60px;resize:none;"></textarea>
                            <div style="text-align:right;margin-top:4px;">
                                <button class="btn btn-black btn-sm" onclick="submitReply(${cmt.cls_reply_no}, this)">등록</button>
                            </div>
                        </div>
                        <%-- 대댓글 목록 --%>
                        <c:forEach var="reply" items="${cmt.replyList}">
                            <div class="reply-item">
                                <div class="comment-meta">
                                    <span class="comment-name">${reply.user_name}</span>
                                    <span>${reply.cls_reply_reg_date}</span>
                                </div>
  						        <%-- 비공개 일때 --%>
									<c:choose>
							            <%-- 부모가 비공개일 때만 권한 체크 --%>
							            <c:when test="${cmt.cls_reply_private == 1}">
							                <c:choose>
							                    <c:when test="${loginUser.user_id eq cmt.user_id || loginUser.user_id eq reply.user_id || loginUser.user_role >= 1}">
							                        <span style="color: #333;">🔒 ${reply.cls_reply_content}</span>
							                    </c:when>
							                    <c:otherwise>
							                        <span style="color: #999; font-style: italic; font-size: 13px;">🔒비공개 댓글입니다. 작성자와 강사만 볼 수 있습니다.</span>
							                    </c:otherwise>
							                </c:choose>
							            </c:when>
							            <c:otherwise>
							                ${reply.cls_reply_content}
							            </c:otherwise>
							        </c:choose>
							<!-- 디자인 수정요망 -->
<c:if test="${loginUser.user_id eq reply.user_id || loginUser.user_role >= 1}">
    <span onclick="deleteCmt(${reply.cls_reply_no})" style="cursor: pointer; font-size: 12px; color: #aaa;"><br>삭제</span>
</c:if>
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
const loginUser = ${not empty sessionScope.loginUser};
var classId = ${lec.class_id};
var lecId = ${lec.lec_id};

function submitComment(){
    if(!loginUser) {
		showAlert('로그인이 필요한 서비스입니다.');
    	return;
	}
    var content  = $('#cmtContent').val().trim();
    // 우리 DB 구조에 맞게 체크하면 1(비공개), 아니면 0(공개)
    var isPrivate = $('#cmtPrivate').is(':checked') ? 1 : 0; 
    if(!content){ showAlert('내용을 입력해주세요.'); return; }

    $.ajax({
        url: '${pageContext.request.contextPath}/class/comment/insert',
        type: 'POST',
        contentType: 'application/json', // JSON으로 보낸다고 명시
        data: JSON.stringify({
            class_id: classId,              // DTO 필드명과 일치
			lec_id: lecId,
            cls_reply_content: content,      // DTO 필드명과 일치
            cls_reply_private: isPrivate,    // DTO 필드명과 일치
            cls_parent_id: null              // 원댓글은 null
        }),
        success: function(res){
            if(res.success) {
                location.reload(); // 성공 시 새로고침해서 댓글 확인
            } else {
                showAlert('등록에 실패했습니다.');
            }
        },
        error: function() {
            showAlert('서버 통신 오류가 발생했습니다.');
        }
    });
}

function submitReply(parentId, btn){
    if(!loginUser) {
		showAlert('로그인이 필요한 서비스입니다.');
   		return;
	}
    // 버튼 기준으로 위쪽에 있는 textarea의 값을 가져옴
    var content = $(btn).closest('div').prev('textarea').val().trim();
    
    if(!content){ showAlert('내용을 입력해주세요.'); return; }

    $.ajax({
        url: '${pageContext.request.contextPath}/class/comment/insert',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            class_id: classId,
            cls_reply_content: content,
            cls_parent_id: parentId, // 부모 댓글 번호를 담음
            cls_reply_private: 0     // 대댓글은 기본적으로 공개 (필요시 수정)
        }),
        success: function(res){
            if(res.success) {
                location.reload();
            }
        }
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

function toggleReply(id){ 
	$('#reply-' + id).toggle(); 
}

//진도율 체크용 hto 0428
let currentIntervalTime = 0;   // 이번 전송 주기(30초) 동안 쌓인 시간
const saveInterval = 30;       // 30초마다 서버로 전송
const totalTime = parseInt("${lec.lec_time}"); 
const goalTime = Math.floor(totalTime / 2);    // 완강 기준(50%)

const timer = setInterval(() => {
    currentIntervalTime++;

    // 1. 30초가 되었을 때 서버에 누적 시간 전송
    if (currentIntervalTime >= saveInterval) {
        console.log("30초 시청 데이터 서버로 전송 중...");
        sendProgress(saveInterval); // 30초를 보냄
        currentIntervalTime = 0;    // 보냈으니 다시 0부터 카운트 시작
    }
}, 1000);

// 서버로 데이터를 보내는 함수
function sendProgress(secondsToAdd) {
    $.ajax({
        url: "${pageContext.request.contextPath}/progress/update",
        type: "POST",
        data: {
            lec_id: "${lec.lec_id}",
            stay_time: secondsToAdd, // "방금 본 30초를 더해라"
            goal_time: goalTime,      // "기준은 이 시간이다"
            lec_prog_status: 0        // 기본 상태값 (DB 쿼리에서 판단하므로 0 고정)
        },
        success: function(res) {
            if(res === "success") {
                console.log("진도 누적 성공 (+" + secondsToAdd + "초)");
            }
        },
        error: function() {
            console.error("진도 업데이트 통신 실패");
        }
    });
}

/*
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
*/
</script>
