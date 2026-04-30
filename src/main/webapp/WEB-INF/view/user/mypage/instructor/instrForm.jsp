<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강사 정보 수정 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    강사 등록신청 & 강사정보수정 공통 폼
    mode = "register" 이면 등록, "edit" 이면 수정
--%>
<c:set var="isEdit" value="${mode == 'edit'}"/>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage/instructor"            class="tab-item active">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/myClass"    class="tab-item">내클래스</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="tab-item">정산내역</a>
    </div>

    <h2 class="section-title">${isEdit ? '강사정보수정' : '강사 등록신청'}</h2>

    <div style="max-width:560px;margin:0 auto;">

        <form id="instrForm"
              action="${pageContext.request.contextPath}/mypage/instructor/${isEdit ? 'update' : 'register'}"
              method="post" enctype="multipart/form-data">

            <div style="border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
                <span style="font-weight:600;">${isEdit ? '강사정보 수정' : '강사등록 신청'}</span>
            </div>

            <div class="form-group">
                <div class="form-label">프로필사진</div>
                <div class="file-upload-row">
                    <input type="text" class="form-control" id="profileFileName" placeholder="프로필사진을 등록 해 주세요." readonly>
                    <button type="button" class="btn btn-black btn-sm" onclick="$('#profileFile').click()">파일첨부</button>
                    <input type="file" id="profileFile" name="profileFile" style="display:none;" accept="image/*"
                           onchange="$('#profileFileName').val(this.files[0].name)">
                </div>
            </div>

            <div class="form-group">
                <div class="form-label">이름</div>
                <input type="text" name="user_name" class="form-control" value="${instructorInfo.user_name}">
            </div>
            <div class="form-group">
                <div class="form-label">전화번호</div>
                <input type="text" name="user_phone" class="form-control" value="${instructorInfo.user_phone}">
            </div>
            <div class="form-group">
                <div class="form-label">이메일</div>
                <input type="email" name="user_email" class="form-control" value="${instructorInfo.user_email}">
            </div>
            <div class="form-group">
                <div class="form-label">강사소개</div>
                <input type="text" name="host_intro" class="form-control" value="${instructorInfo.host_intro}" placeholder="안녕하세요 금융분야 JAVA 개발자 김명신 입니다.">
            </div>
            <div class="form-group">
                <div class="form-label">상세소개</div>
                <input type="text" name="host_intro" class="form-control" value="${instructorInfo.host_description}" placeholder="상세한 소개">
            </div>
            <div class="form-group">
                <div class="form-label">은행명</div>
                <input type="text" name="host_bank_name" class="form-control" value="${instructorInfo.host_bank_name}" placeholder="카카오뱅크">
            </div>
            <div class="form-group">
                <div class="form-label">계좌번호</div>
                <input type="text" name="host_bank_account" class="form-control" value="${instructorInfo.host_bank_account}" placeholder="3333-333333-333">
            </div>
            <div class="form-group">
                <div class="form-label">예금주명</div>
                <input type="text" name="host_account_owner" class="form-control" value="${instructorInfo.host_account_owner}">
            </div>

            <div style="text-align:center;margin-top:28px;">
                <button type="submit" class="btn btn-black btn-lg" style="min-width:180px;">
                    ${isEdit ? '수정하기' : '신청하기'}
                </button>
            </div>
        </form>
    </div>
</div>
</main>
