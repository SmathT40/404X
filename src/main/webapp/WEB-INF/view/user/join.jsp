<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>회원가입 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content" style="max-width:600px;">

    <h1 class="section-title">회원가입</h1>
    <p class="section-subtitle">404 X CLUB에 오신 걸 환영합니다</p>

    <form id="joinForm" action="${pageContext.request.contextPath}/user/join" method="post">

        <%-- ID / PW 섹션 --%>
        <div style="margin-bottom:28px;">
            <div style="display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
                <span style="font-weight:600;">ID / PW</span>
                <span style="font-size:12px;color:#e63946;">* 표시 항목은 필수 입력합니다.</span>
            </div>

            <%-- 아이디 --%>
            <div class="form-group">
                <div class="form-label">아이디 <span style="color:#e63946;">*</span></div>
                <div class="form-inline">
                    <input type="text" id="userId" name="user_id" class="form-control"
                           placeholder="아이디를 입력해 주세요." maxlength="20" value="${user.user_id}">
                    <button type="button" class="btn btn-black btn-sm" style="white-space:nowrap;"
                            onclick="checkDupId()">중복확인</button>
                </div>
                <div id="idMsg" style="font-size:12px;margin-top:4px;"></div>
            </div>

            <%-- 비밀번호 --%>
            <div class="form-group">
                <div class="form-label">비밀번호 <span style="color:#e63946;">*</span></div>
                <input type="password" id="userPw" name="user_pw" class="form-control"
                       placeholder="비밀번호를 입력해 주세요.">
            </div>

            <%-- 비밀번호 확인 --%>
            <div class="form-group">
                <div class="form-label">비밀번호 확인 <span style="color:#e63946;">*</span></div>
                <input type="password" id="userPwChk" name="user_pw_chk" class="form-control"
                       placeholder="비밀번호를 입력해 주세요.">
                <div id="pwMsg" style="font-size:12px;margin-top:4px;"></div>
            </div>
        </div>

        <%-- 상세정보 섹션 --%>
        <div style="margin-bottom:28px;">
            <div style="border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
                <span style="font-weight:600;">상세정보</span>
            </div>

            <div class="form-group">
                <div class="form-label">이름 <span style="color:#e63946;">*</span></div>
                <input type="text" id="userName" name="user_name" class="form-control"
                       placeholder="이름을 입력해 주세요." value="${user.user_name}">
            </div>

            <div class="form-group">
                <div class="form-label">생년월일 <span style="color:#e63946;">*</span></div>
                <input type="text" id="userBirth" name="user_birth" class="form-control"
                       placeholder="생년월일을 입력해 주세요. ( ex. 19981102 )" maxlength="8" value="${user.user_birth}">
            </div>

            <div class="form-group">
                <div class="form-label">전화번호 <span style="color:#e63946;">*</span></div>
                <input type="text" id="userPhone" name="user_phone" class="form-control"
                       placeholder="전화번호를 입력해 주세요 (ex. 01011112222)." maxlength="11" value="${user.user_phone}">
            </div>

            <div class="form-group">
                <div class="form-label">이메일</div>
                <input type="email" id="userEmail" name="user_email" class="form-control"
                       placeholder="이메일을 입력해 주세요." value="${user.user_email}">
            </div>
        </div>

        <%-- 개인정보 동의 --%>
        <div class="form-group">
            <label class="check-label" style="background:#f9f9f9;border:1px solid #eee;border-radius:8px;padding:12px 16px;display:flex;gap:10px;">
                <input type="checkbox" id="agreePrivacy" name="agreePrivacy" value="Y">
                <span><strong style="color:#e63946;">[필수]</strong> 개인정보처리방침에 동의합니다.
                    <a href="#" style="color:#e63946;font-size:12px;">[전문보기]</a>
                </span>
            </label>
        </div>

        <button type="button" class="btn btn-black btn-full btn-lg" onclick="doJoin()">회원가입</button>

    </form>
</div>
</main>

<script>
var idChecked = false;

/* 아이디 중복확인 */
function checkDupId(){
    var id = $('#userId').val().trim();
    if(!id){ showAlert('아이디를 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/user/checkId',
        {user_id: id}, 'POST',
        function(res){
            if(res.available){
                $('#idMsg').text('사용 가능한 아이디입니다.').css('color','#166534');
                idChecked = true;
            } else {
                $('#idMsg').text('이미 사용 중인 아이디입니다.').css('color','#991b1b');
                idChecked = false;
            }
        }
    );
}

/* 비밀번호 일치 확인 */
$('#userPwChk').on('input', function(){
    if($('#userPw').val() === $(this).val()){
        $('#pwMsg').text('비밀번호가 일치합니다.').css('color','#166534');
    } else {
        $('#pwMsg').text('비밀번호가 일치하지 않습니다.').css('color','#991b1b');
    }
});

/* 아이디 입력 칸에 글자를 치면 중복확인 상태 초기화 */
$('#userId').on('input', function () {	// 이 'input' 이라는 거 덕에 쪼금이라도 바뀌는 순간 바로 아래 함정 카드 발동! 빰!빰빠빠빠바라바바빰!빰!
	// 중복 확인 통과 상태를 즉시 취소
	idChecked = false;
	
	// 입력칸 아래 메세지를 다시 빨간색 경고로 리셋
	$('#idMsg').text('아이디 중복 확인이 필요합니다.').css('color', '#991b1b');
})

/* 회원가입 제출 */
function doJoin(){
    if(!idChecked){ showAlert('아이디 중복확인을 해주세요.'); return; }
    if(!validateRequired('userName','이름을 입력해주세요.')) return;
    if(!validateRequired('userBirth','생년월일을 입력해주세요.')) return;
    if(!validateRequired('userPhone','전화번호를 입력해주세요.')) return;
    if($('#userPw').val() !== $('#userPwChk').val()){ showAlert('비밀번호가 일치하지 않습니다.'); return; }
    if(!$('#agreePrivacy').is(':checked')){ showAlert('개인정보처리방침에 동의해주세요.'); return; }
    $('#joinForm').submit();
}
</script>
