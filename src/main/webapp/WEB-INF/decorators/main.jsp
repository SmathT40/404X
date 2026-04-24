<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/></title>

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
        
   	<style>
        /* 기존 디자인 유지를 위한 커스텀 스타일 오버라이딩 */
        .gnb { background-color: #fff; border-bottom: 1px solid #eee; }
        .gnb-menu { list-style: none; margin: 0; padding: 0; display: flex; align-items: center; }
        .gnb-menu > li > a { 
            display: block; padding: 15px 20px; color: #333; font-weight: 500; text-decoration: none; 
        }
        
        /* 부트스트랩 드롭다운을 '호버' 방식으로 변경하는 위쪽 코드 논리 */
        .nav-item.dropdown:hover .dropdown-menu { 
            display: block; 
            margin-top: 0; 
            border-radius: 0 0 4px 4px;
            border: 1px solid #eee;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .dropdown-item { padding: 10px 20px; font-size: 14px; }
        .dropdown-item:hover { background-color: #f8f9fa; color: #e63946; }
        
        /* 디자인 포인트: 화살표 제거 (기존 디자인 유지) */
        .dropdown-toggle::after { display: none; }
    </style>

    <sitemesh:write property="head"/>
</head>
<body>
<div class="wrap">
    <%-- 헤더 --%>
    <header id="header">
        <div class="header-top">
            <a href="${pageContext.request.contextPath}/" class="header-logo">404 X CLUB</a>
            <div class="header-utils">
           
	            <c:choose>
	            
	                <c:when test="${not empty sessionScope.loginUser}">
	                 
	                    <%-- 로그인 상태 --%>
	                    <a href="${pageContext.request.contextPath}/mypage/classroom">&#128218; 내강의실</a>
	                    <a href="${pageContext.request.contextPath}/mypage">&#128100; 마이페이지</a>
	                    <a href="${pageContext.request.contextPath}/payment/cart">&#128722; 장바구니</a>
	                    <a href="${pageContext.request.contextPath}/user/logout">&#128682; 로그아웃</a>
	                
	                </c:when>
	                <c:otherwise>
	                    <%-- 비로그인 상태--%>
	                    <a href="${pageContext.request.contextPath}/user/login">&#128275; 로그인</a>
	                    <a href="${pageContext.request.contextPath}/user/join">&#128221; 회원가입</a>
	                </c:otherwise>
	                
	            </c:choose>
	             
            </div>
        </div>

        <%-- GNB: 부트스트랩 클래스 구조 이식 --%>
        <nav class="gnb navbar navbar-expand-lg navbar-light">
            <div class="container-fluid justify-content-center">
                <ul class="gnb-menu navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">학원소개</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/instructor/list">강사소개</a></li>
                    
                    <%-- 교육과정 드롭다운 (DB 데이터 연동) --%>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle">강의목록</a>
                        <div class="dropdown-menu">
                            <c:forEach var="cls" items="${clsList}">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/class/list?cat=${cls.category_code}">
                                    ${cls.category_name}
                                </a>
                            </c:forEach>
                        </div>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#">커뮤니티</a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/community/board/list?boardid=0">공지사항</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/community/board/list?boardid=1">자유게시판</a>
                        </div>
                    </li>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#">학습지원</a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/community/board/list?boardid=3">1:1문의</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/community/board/list?boardid=2">FAQ</a>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
    </header>

    <main class="content-area container mt-4">
        <sitemesh:write property="body"/>
    </main>
</div>

<%-- 푸터 생략 (기존 것 유지) --%>
<footer id="footer">
    <div class="footer-inner">
        <div class="footer-info">
            &copy; 2026 404 X CLUB. All rights reserved. &nbsp;|&nbsp;
            <a href="mailto:404xclubadmin@xclub.com">404xclubadmin@xclub.com</a>
        </div>
        <div>Tel: +82 2 111 2223 &nbsp;|&nbsp; Fax: +82 2 111 2222</div>
    </div>
</footer>

<%-- 맨 위로 버튼 --%>
<button id="scroll-top" onclick="window.scrollTo({top:0, behavior:'smooth'})">&#8593;</button>

<%-- 공통 모달 오버레이 (JS로 제어) --%>
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