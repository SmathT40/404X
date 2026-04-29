<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>마이페이지 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <%-- 탭바 --%>
    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage/index"           class="tab-item active">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/classroom" class="tab-item">내강의실</a>
        <a href="${pageContext.request.contextPath}/mypage/myPost"    class="tab-item">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/payment"   class="tab-item">결제내역</a>
    </div>

    <h2 class="section-title">마이페이지</h2>

    <div style="max-width:560px;margin:0 auto;">

        <%-- 상세정보 헤더 --%>
        <div style="display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #eee;padding-bottom:10px;margin-bottom:20px;">
            <span style="font-weight:600;">상세정보</span>
            <div style="display:flex;gap:8px;">
                <c:if test="${sessionScope.loginUser.user_role == 1}">
                    <a href="${pageContext.request.contextPath}/mypage/instructor" class="btn btn-ghost btn-sm">강사마이페이지</a>
                </c:if>
                <c:if test="${sessionScope.loginUser.user_role == 0}">
                    <button class="btn btn-ghost btn-sm" onclick="openInstructorRegModal()">강사등록</button>
                </c:if>
                <a href="${pageContext.request.contextPath}/mypage/editInfo" class="btn btn-black btn-sm">개인정보 수정</a>
            </div>
        </div>

        <%-- 회원 정보 표시 --%>
        <div class="form-group">
            <div class="form-label">이름 <span style="color:#e63946;">*</span></div>
            <input type="text" class="form-control" value="${sessionScope.loginUser.user_name}" readonly style="background:#f9f9f9;">
        </div>
        <div class="form-group">
            <div class="form-label">생년월일 <span style="color:#e63946;">*</span></div>
            <input type="text" class="form-control" value="${sessionScope.loginUser.user_birth}" readonly style="background:#f9f9f9;">
        </div>
        <div class="form-group">
            <div class="form-label">전화번호 <span style="color:#e63946;">*</span></div>
            <input type="text" class="form-control" value="${sessionScope.loginUser.user_phone}" readonly style="background:#f9f9f9;">
        </div>
        <div class="form-group">
            <div class="form-label">이메일</div>
            <input type="text" class="form-control" value="${sessionScope.loginUser.user_email}" readonly style="background:#f9f9f9;">
        </div>

        <div style="text-align:right;margin-top:20px;">
            <a href="#" onclick="openWithdrawModal();return false;" style="font-size:13px;color:#aaa;text-decoration:underline;">탈퇴하기</a>
        </div>
    </div>
</div>
</main>

<%-- 강사등록 인증코드 모달 --%>
<div class="modal-overlay" id="instructorRegModal">
    <div class="modal-box" style="text-align:left;padding:32px 36px;">
        <div class="modal-title">강사등록하기</div>
        <div class="form-group">
            <div class="form-label">인증코드</div>
            <input type="text" id="instrCode" class="form-control" placeholder="인증코드를 입력해 주세요.">
        </div>
        <p style="font-size:12px;color:#e63946;margin-bottom:16px;">인증코드 분실 시 관리자에게 문의바랍니다.</p>
        <div class="modal-actions">
            <button class="btn btn-ghost" onclick="$('#instructorRegModal').removeClass('active')">닫기</button>
            <button class="btn btn-black" onclick="doInstructorReg()">확인</button>
        </div>
    </div>
</div>

<%-- 회원탈퇴 모달 --%>
<div class="modal-overlay" id="withdrawModal">
    <div class="modal-box" style="text-align:left;padding:32px 36px;">
        <div class="modal-title">회원탈퇴</div>
        <div class="form-group">
            <div class="form-label">비밀번호</div>
            <input type="password" id="withdrawPw" class="form-control" placeholder="비밀번호를 입력해 주세요.">
        </div>
        <p style="font-size:12px;color:#e63946;margin-bottom:16px;">탈퇴시, 복구가 불가능 합니다.</p>
        <div class="modal-actions">
            <button class="btn btn-ghost" onclick="$('#withdrawModal').removeClass('active')">닫기</button>
            <button class="btn btn-black" onclick="doWithdraw()">확인</button>
        </div>
    </div>
</div>

<script>
/*
function doInstructorReg(){
    var code = $('#instrCode').val().trim();
    if(!code){ showAlert('인증코드를 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/user/instructorReg',
        {auth_code: code}, 'POST',
        function(res){
            if(res.success){
                showAlert('강사 등록 신청이 완료되었습니다.', function(){ location.href='${pageContext.request.contextPath}/mypage/instructor/register'; });
            } else {
                showAlert('인증코드가 올바르지 않습니다.');
            }
        }
    );
}

지금 인증코드 구현 안 했으니까 그냥 빈칸 입력해도 들어갈 수 있게 ***잠시*** 주석 처리 했음여
*/

function doInstructorReg(){
    // 1. 입력값이 있는지 최소한의 체크만 (비어있으면 서운하니까 ㅋㅋㅋ)
    var code = $('#instrCode').val().trim();
    if(!code){ 
        showAlert('테스트 모드: 아무 코드나 입력하면 통과됩니다!'); 
        return; 
    }

    // 2. AJAX는 나중에 로직 완성되면 다시 살리고, 지금은 '무조건 성공' 시뮬레이션!
    /*
    ajaxRequest('${pageContext.request.contextPath}/user/instructorReg',
        {auth_code: code}, 'POST',
        function(res){ ... }
    );
    */

    // 🚀 임시 하이패스 로직
    showAlert('인증코드가 확인되었습니다. 신청 페이지로 이동합니다.', function(){ 
        location.href='${pageContext.request.contextPath}/mypage/instructor/register'; 
    });
}

function doWithdraw(){
    var pw = $('#withdrawPw').val().trim();
    if(!pw){ showAlert('비밀번호를 입력해주세요.'); return; }
    ajaxRequest('${pageContext.request.contextPath}/user/withdraw',
        {user_pw: pw}, 'POST',
        function(res){
            if(res.success){ location.href='${pageContext.request.contextPath}/'; }
            else { showAlert('비밀번호가 올바르지 않습니다.'); }
        }
    );
}
</script>
