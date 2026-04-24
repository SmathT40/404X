<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강사 마이페이지 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage/instructor"            class="tab-item active">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/myClass"    class="tab-item">내클래스</a>
        <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="tab-item">정산내역</a>
    </div>

    <h2 class="section-title">강사 마이페이지</h2>

    <div style="max-width:560px;margin:0 auto;">
        <div style="display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #eee;padding-bottom:10px;margin-bottom:20px;">
            <span style="font-weight:600;">강사상세정보</span>
            <a href="${pageContext.request.contextPath}/mypage/instructor/editInfo" class="btn btn-black btn-sm">개인정보 수정</a>
        </div>

        <div class="form-group">
            <div class="form-label">프로필사진</div>
            <div style="width:100%;height:80px;border:1px solid #ddd;border-radius:4px;display:flex;align-items:center;padding:0 14px;font-size:13px;color:#aaa;background:#f9f9f9;">
                <c:choose>
                    <c:when test="${not empty instructorInfo.profileImg}">
                        <img src="${instructorInfo.profileImg}" style="height:60px;border-radius:4px;">
                    </c:when>
                    <c:otherwise>사진이 들어갈 공간입니다.</c:otherwise>
                </c:choose>
            </div>
        </div>

        <c:set var="info" value="${instructorInfo}"/>
        <div class="form-group"><div class="form-label">이름</div>
            <input type="text" class="form-control" value="${info.userName}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">전화번호</div>
            <input type="text" class="form-control" value="${info.userPhone}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">이메일</div>
            <input type="text" class="form-control" value="${info.userEmail}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">강사소개</div>
            <input type="text" class="form-control" value="${info.intro}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">강의과목</div>
            <input type="text" class="form-control" value="${info.subject}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">은행명</div>
            <input type="text" class="form-control" value="${info.bankName}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">계좌번호</div>
            <input type="text" class="form-control" value="${info.accountNo}" readonly style="background:#f9f9f9;"></div>
        <div class="form-group"><div class="form-label">예금주명</div>
            <input type="text" class="form-control" value="${info.accountName}" readonly style="background:#f9f9f9;"></div>
    </div>
</div>
</main>
