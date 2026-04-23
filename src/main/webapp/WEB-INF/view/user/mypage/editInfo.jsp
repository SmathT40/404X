<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>정보 수정 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage"           class="tab-item active">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/classroom" class="tab-item">내강의실</a>
        <a href="${pageContext.request.contextPath}/mypage/myPost"    class="tab-item">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/payment"   class="tab-item">결제내역</a>
    </div>

    <h2 class="section-title">개인정보수정</h2>

    <div style="max-width:560px;margin:0 auto;">

        <%-- 비밀번호 변경 --%>
        <div style="border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
            <span style="font-weight:600;">비밀번호 변경</span>
        </div>
        <form id="pwForm" action="${pageContext.request.contextPath}/mypage/updatePw" method="post">
            <div class="form-group">
                <div class="form-label">현재 비밀번호</div>
                <input type="password" name="currentPw" class="form-control" placeholder="비밀번호를 입력해 주세요.">
            </div>
            <div class="form-group">
                <div class="form-label">비밀번호</div>
                <input type="password" id="newPw" name="newPw" class="form-control" placeholder="비밀번호를 입력해 주세요.">
            </div>
            <div class="form-group">
                <div class="form-label">비밀번호 확인</div>
                <input type="password" id="newPwChk" name="newPwChk" class="form-control" placeholder="비밀번호를 입력해 주세요.">
            </div>
            <div style="text-align:center;margin:20px 0 32px;">
                <button type="button" class="btn btn-black btn-lg" style="min-width:180px;" onclick="doUpdatePw()">수정하기</button>
            </div>
        </form>

        <%-- 상세정보 수정 --%>
        <div style="border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
            <span style="font-weight:600;">상세정보 수정</span>
        </div>
        <form id="infoForm" action="${pageContext.request.contextPath}/mypage/updateInfo" method="post">
            <div class="form-group">
                <div class="form-label">이름</div>
                <input type="text" name="userName" class="form-control" value="${sessionScope.loginUser.userName}">
            </div>
            <div class="form-group">
                <div class="form-label">생년월일</div>
                <input type="text" name="userBirth" class="form-control" value="${sessionScope.loginUser.userBirth}">
            </div>
            <div class="form-group">
                <div class="form-label">전화번호</div>
                <input type="text" name="userPhone" class="form-control" value="${sessionScope.loginUser.userPhone}">
            </div>
            <div class="form-group">
                <div class="form-label">이메일</div>
                <input type="email" name="userEmail" class="form-control" value="${sessionScope.loginUser.userEmail}">
            </div>
            <div style="text-align:center;margin-top:24px;">
                <button type="submit" class="btn btn-black btn-lg" style="min-width:180px;">수정하기</button>
            </div>
        </form>

    </div>
</div>
</main>

<script>
function doUpdatePw(){
    var np = $('#newPw').val(), nc = $('#newPwChk').val();
    if(!np){ showAlert('새 비밀번호를 입력해주세요.'); return; }
    if(np !== nc){ showAlert('비밀번호가 일치하지 않습니다.'); return; }
    $('#pwForm').submit();
}
</script>
