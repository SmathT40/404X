<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><sitemesh:write property='title'/> - 관리자</title>

<%-- 1. 기존 레이아웃의 핵심 라이브러리 (디자인 유지용) --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>  
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>

<%-- 개별 페이지의 추가 head 내용 삽입 --%>
<sitemesh:write property="head"/>

<style>
/* 어드민 전용 레이아웃 보정 (기존 common.css와 충돌 방지) */
.admin-wrap { display: flex; min-height: 100vh; background-color: #f8f9fa; }
.sidebar-admin { width: 260px; background-color: #1a1a1a; color: #fff; flex-shrink: 0; }
.admin-content { flex: 1; display: flex; flex-direction: column; min-width: 0; }
.admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
.admin-main { padding: 30px; flex: 1; }

/* 기존 디자인 톤 유지: 사이드바 메뉴 스타일 */
.sidebar-logo { padding: 25px; font-size: 20px; font-weight: 900; border-bottom: 1px solid #333; }
.sidebar-logo a { color: #fff; text-decoration: none; }
.sidebar-title { padding: 20px 25px 10px; font-size: 12px; color: #666; text-transform: uppercase; }
.sidebar-admin ul { list-style: none; padding: 0; margin: 0; }
.sidebar-admin ul li a { display: block; padding: 12px 25px; color: #bbb; text-decoration: none; transition: 0.3s; font-size: 15px; }
.sidebar-admin ul li a:hover { background-color: #333; color: #fff; }
.sidebar-footer { margin-top: auto; padding: 20px; border-top: 1px solid #333; display: flex; gap: 15px; font-size: 13px; }
.sidebar-footer a { color: #888; text-decoration: none; }
.admin-wrap {
    display: flex;
    align-items: flex-start; /* 필수: 자식 요소들이 부모 높이를 꽉 채우지 않게 함 */
}

.sidebar-admin {
    width: 260px;
    background-color: #1a1a1a;
    color: #fff;
    height: 100vh;      /* 화면 높이를 꽉 채워야 바닥이 생깁니다 */
    position: sticky;
    top: 0;
    
    /* [추가] 내부 요소들을 세로로 정렬하고 간격을 조절할 수 있게 함 */
    display: flex;
    flex-direction: column;
    overflow-y: auto;   /* 메뉴가 길어지면 사이드바 안에서 스크롤 가능하게 함 */
}
.sidebar-admin.instructor-mode {
}

.sidebar-admin ul {
    list-style: none;
    padding: 0;
    margin: 0;
    
    /* [추가] 메뉴 영역이 남는 공간을 모두 차지하게 해서 푸터를 아래로 밀어냄 */
    flex: 1; 
    overflow-y: auto; /* 메뉴가 너무 많아지면 이 영역만 스크롤됨 */
}

.sidebar-footer {
    /* 기존 스타일 유지 */
    padding: 20px;
    border-top: 1px solid #333;
    display: flex;
    gap: 15px;
    font-size: 13px;
    
    /* [추가] 혹시 모르니 바닥에 딱 고정 */
    margin-top: auto; 
}

</style>
</head>
<c:set var="userRole" value="${sessionScope.loginUser.user_role}" />
<body class="admin-body">

<div class="admin-wrap">

    <%-- 관리자 사이드바 --%>
    <aside class="sidebar-admin" >
        <div class="sidebar-logo">
            <a href="${pageContext.request.contextPath}/">404 X CLUB</a>
        </div>

        <c:choose>
            <%-- 관리자 --%>
            <c:when test="${userRole == 2}">
                <div class="sidebar-title">관리 메뉴</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">&#128202; 대시보드</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/member/list">&#128100; 회원관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/host/list">🤓 강사관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/class/list?status=1">&#128218; 강의관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/category/admin/list">📁 카테고리관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/board/list">&#128203; 게시판관리</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/payment/main">&#128176; 결제관리</a></li>
                </ul>
            </c:when>

            <%-- 강사 --%>
            <c:when test="${userRole == 1}">
                <div class="sidebar-title">강사 메뉴</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/mypage/instructor">&#127968; 강사 홈</a></li>
                    <li><a href="${pageContext.request.contextPath}/host/class/status">&#128218; 내 강의</a></li>
                    <li><a href="${pageContext.request.contextPath}/host/class/classForm">&#10133; 강의 등록</a></li>
                    <li><a href="${pageContext.request.contextPath}/mypage/instructor/editInfo">&#9999; 정보 수정</a></li>
                </ul>
            </c:when>
        </c:choose>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/">&#127968; 사이트로</a>
            <a href="${pageContext.request.contextPath}/user/logout">&#128682; 로그아웃</a>
        </div>
    </aside>


    <%-- 콘텐츠 영역 (공통) --%>
    <div class="admin-content">
        <header class="admin-header">
            <div class="admin-header-title" style="font-size: 18px; font-weight: 700; color: #333;">
                <sitemesh:write property='title'/>
            </div>

            <div class="admin-header-user" style="font-size: 14px; color: #555;">
                <c:if test="${not empty sessionScope.loginUser}">
                    <strong>${sessionScope.loginUser.user_name}</strong>
                    <c:choose>
                        <c:when test="${userRole == 2}">님 (관리자)</c:when>
                        <c:when test="${userRole == 1}">님 (강사)</c:when>
                    </c:choose>
                </c:if>
            </div>
        </header>

        <main class="admin-main">
            <sitemesh:write property="body"/>
        </main>
    </div>

</div>

<%-- 공통 모달 오버레이 (기존 logic 유지) --%>
<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">알림</div>
        <div class="modal-body" id="modalBody"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn" onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

</body>
</html>