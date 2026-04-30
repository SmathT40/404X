<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>로그인 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content" style="max-width:500px;">

    <h1 class="section-title" style="font-size:28px;font-weight:900;letter-spacing:2px;">LOGIN</h1>

    <form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="post">

        <%-- 오류 메시지 --%>
        <c:if test="${not empty errorMsg}">
            <div style="background:#fee2e2;color:#991b1b;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;">
                ${errorMsg}
            </div>
        </c:if>

        <%-- 아이디 --%>
        <div class="form-group">
            <div style="position:relative;">
                <input type="text" id="userId" name="user_id"
                       class="form-control" placeholder="아이디를 입력해 주세요."
                       value="${cookie.savedId.value}" style="padding-right:40px;">
                <span id="clearId" style="position:absolute;right:12px;top:50%;transform:translateY(-50%);cursor:pointer;color:#aaa;display:none;">&#10005;</span>
            </div>
        </div>

        <%-- 비밀번호 --%>
        <div class="form-group">
            <input type="password" id="userPw" name="user_pw"
                   class="form-control" placeholder="패스워드를 입력해 주세요.">
        </div>

        <%-- 아이디/비밀번호 찾기 --%>
        <div style="text-align:right;margin-bottom:20px;font-size:12px;color:#888;">
            <a href="#" onclick="openFindId();return false;">아이디찾기</a>
            &nbsp;|&nbsp;
            <a href="#" onclick="openFindPw();return false;">비밀번호 찾기</a>
        </div>

        <%-- 로그인 버튼 --%>
        <button type="submit" class="btn btn-black btn-full btn-lg" style="margin-bottom:10px;">로그인</button>

        <%-- 네이버 로그인 버튼 --%>
        <a href="${pageContext.request.contextPath}/user/naver/login" class="btn-naver">
            <span style="font-weight:900;margin-right:6px;">N</span> 네이버 로그인
        </a>

    </form>

</div>
</main>

<%-- 아이디 찾기 모달 --%>
<div class="modal-overlay" id="findIdModal">
    <div class="modal-box" style="max-width:440px; text-align:left; padding:32px 36px;">
        <div class="modal-title">아이디 찾기</div>
        <div class="form-group">
            <div class="form-label">이름</div>
            <input type="text" id="findId_name" class="form-control" placeholder="이름을 입력해 주세요.">
        </div>
        <div class="form-group">
            <div class="form-label">이메일</div>
            <input type="email" id="findId_email" class="form-control" placeholder="이메일을 입력해 주세요.">
        </div>
        <div style="text-align:center;margin:8px 0 12px;font-size:12px;">
            <a href="#" onclick="$('#findIdModal').removeClass('active');openFindPw();return false;">비밀번호 찾기</a>
        </div>
        <div id="findIdResult" style="display:none;background:#f5f5f5;border-radius:8px;padding:12px;font-size:13px;text-align:center;margin-bottom:14px;"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" onclick="$('#findIdModal').removeClass('active')">닫기</button>
            <button class="btn btn-black" onclick="doFindId()">확인</button>
        </div>
    </div>
</div>

<%-- 비밀번호 찾기 모달 --%>
<div class="modal-overlay" id="findPwModal">
    <div class="modal-box" style="max-width:440px; text-align:left; padding:32px 36px;">
        <div class="modal-title">비밀번호 찾기</div>
        <div class="form-group">
            <div class="form-label">아이디</div>
            <input type="text" id="findPw_id" class="form-control" placeholder="아이디를 입력해 주세요.">
        </div>
        <div class="form-group">
            <div class="form-label">이름</div>
            <input type="text" id="findPw_name" class="form-control" placeholder="이름을 입력해 주세요.">
        </div>
        <div class="form-group">
            <div class="form-label">이메일</div>
            <input type="email" id="findPw_email" class="form-control" placeholder="이메일을 입력해 주세요.">
        </div>
        <div style="text-align:center;margin:8px 0 12px;font-size:12px;">
            <a href="#" onclick="$('#findPwModal').removeClass('active');openFindId();return false;">아이디 찾기</a>
        </div>
        <div id="findPwResult" style="display:none;background:#f5f5f5;border-radius:8px;padding:12px;font-size:13px;text-align:center;margin-bottom:14px;"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" onclick="$('#findPwModal').removeClass('active')">닫기</button>
            <button class="btn btn-black" onclick="doFindPw()">확인</button>
        </div>
    </div>
</div>


<script>
$(document).ready(function(){
    /* 아이디 입력 시 X 버튼 표시 */
    $('#userId').on('input', function(){
        $('#clearId').toggle($(this).val().length > 0);
    }).trigger('input');

    $('#clearId').on('click', function(){
        $('#userId').val('').focus();
        $(this).hide();
    });
});

/* 아이디 찾기 AJAX */
function doFindId(){
    var name  = $('#findId_name').val().trim();
    var email = $('#findId_email').val().trim();
    if(!name || !email){ showAlert('이름과 이메일을 입력해주세요.'); return; }

    ajaxRequest('${pageContext.request.contextPath}/user/findId',
        {user_name: name, user_email: email}, 'POST',
        function(res){
            if(res.success){
                $('#findIdResult').text('회원님의 아이디는 ' + res.user_id + ' 입니다.').show();
            } else {
                showAlert('일치하는 회원 정보가 없습니다.');
            }
        }
    );
}

/* 비밀번호 찾기 AJAX */
function doFindPw(){
    var id    = $('#findPw_id').val().trim();
    var name  = $('#findPw_name').val().trim();
    var email = $('#findPw_email').val().trim();
    if(!id || !name || !email){ showAlert('모든 항목을 입력해주세요.'); return; }

    ajaxRequest('${pageContext.request.contextPath}/user/findPw',
        {user_id: id, user_name: name, user_email: email}, 'POST',
        function(res){
            if(res.success){
                $('#findPwResult').text('회원님의 이메일로 임시비밀번호가 전송 되었습니다.').show();
            } else {
                showAlert('일치하는 회원 정보가 없습니다.');
            }
        }
    );
}
$(document).ready(function() {
	const urlParams = new URLSearchParams(window.location.search);
	const msg = urlParams.get('msg');
    
    if (msg) {
        openModal('', msg, function() {
        }, false);
        history.replaceState({}, null, window.location.pathname);
    }
});
</script>
