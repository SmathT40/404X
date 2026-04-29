<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 상세 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<main class="content-area">
<div class="user-content" style="max-width:860px;">

    <%-- 강의 제목/정보 --%>
    <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:20px;">
        <div>
            <h1 style="font-size:22px;font-weight:700;margin-bottom:6px;">${cls.cls_title}</h1>
            <div style="font-size:13px;color:#888;">
                ${cls.user_name} 강사 &nbsp;|&nbsp;
                <!--  
                수강기간 ${classVO.startDate} ~ ${classVO.endDate}
                -->
            </div>
        </div>
        <div style="font-size:22px;font-weight:700;color:#222;">
            <fmt:formatNumber value="${cls.cls_price}" pattern="#,###"/>원
        </div>
    </div>

    <hr style="border:none;border-top:1px solid #eee;margin-bottom:24px;">

    <%-- 강의 소개 본문 --%>
    <div style="line-height:1.9;font-size:14px;color:#333;margin-bottom:32px;">
        ${cls.cls_content}
    </div>

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
                <span class="nav-label">&#8743; 이전글</span>
                <a href="${pageContext.request.contextPath}/class/detail?id=${prevLecture.classId}">${prevLecture.title}</a>
            </div>
        </c:if>
        <c:if test="${not empty nextLecture}">
            <div class="post-nav-item">
                <span class="nav-label">&#8744; 다음글</span>
                <a href="${pageContext.request.contextPath}/class/detail?id=${nextLecture.classId}">${nextLecture.title}</a>
            </div>
        </c:if>
    </div>

</div>
</main>

<%-- 하단 고정 구매 버튼 --%>
<div style="position:fixed;bottom:0;left:0;right:0;background:#fff;border-top:1px solid #eee;padding:14px 24px;display:flex;justify-content:center;gap:16px;z-index:800;">
    <button class="btn btn-ghost btn-lg" onclick="addToCart(${cls.class_id})">&#128722;</button>
    <a href="${pageContext.request.contextPath}/class/list" class="btn btn-ghost btn-lg" style="min-width:100px;">목록</a>
    <a href="${pageContext.request.contextPath}/class/leclist?class_id=${cls.class_id}" class="btn btn-ghost btn-lg" style="min-width:100px;">임시버튼</a>
    <button class="btn btn-black btn-lg" style="min-width:120px;" onclick="buyNow(${cls.class_id})">구매하기</button>
</div>

<div style="height:80px;"></div><%-- 하단 버튼 높이 보정 --%>

<script>
var classId = ${cls.class_id};

function submitComment(){
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

function toggleReply(id){ $('#reply-' + id).toggle(); }


var classId = ${cls.class_id};

//1. addToCart 함수를 조금 수정 (성공 시 실행할 함수를 인자로 받음)
function addToCart(id, callback){
    ajaxRequest('${pageContext.request.contextPath}/payment/cart/add', {class_id: id}, 'POST',
        function(res){ 
            if(res.success) {
                if(callback) {
                    callback(); // 성공했을 때만 다음 동작(이동) 수행
                } else {
                    showAlert('장바구니에 추가되었습니다.');
                }
            } else {
                showAlert(res.msg);
            }
        });
}
function buyNow(id){
    ajaxRequest('${pageContext.request.contextPath}/payment/cart/add', {class_id: id}, 'POST', function(res){
        // res.success가 true이거나, 
        // 혹은 실패했더라도 메시지가 "이미 장바구니..."라면 그냥 이동시킨다!
        if(res.success || res.msg.indexOf('이미 장바구니') > -1) {
            location.href = '${pageContext.request.contextPath}/payment/checkout?cartIds=' + 0;
        } else {
            showAlert(res.msg);
        }
    });
}

/*
// 2. buyNow 함수 수정
function buyNow(id){
    // 장바구니에 담는 게 성공하면, 그때 결제 페이지로 가라!
    addToCart(id, function() {
        // 바로 구매는 보통 이 상품 하나만 결제하는 경우가 많으므로
        // 체크박스 로직(gotoCheckout) 대신 직접 경로를 지정하는 게 안전합니다.
        location.href = '${pageContext.request.contextPath}/payment/checkout?cartIds=' + 0;
    });
}
*/
/*
function submitComment(){
    var content  = $('#cmtContent').val().trim();
    var isPrivate = $('#cmtPrivate').is(':checked') ? 'Y' : 'N';
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/lecture/comment/insert',
        {classId: classId, content: content, openYn: isPrivate == 'Y' ? 'N' : 'Y'}, 'POST',
        function(res){ if(res.success) location.reload(); }
    );
}
function submitReply(parentId, btn){
    var content = $(btn).closest('div').prev('textarea').val().trim();
    if(!content){ showAlert('내용을 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/lecture/comment/insert',
        {classId: classId, content: content, parentId: parentId}, 'POST',
        function(res){ if(res.success) location.reload(); }
    );
}
*/
</script>
