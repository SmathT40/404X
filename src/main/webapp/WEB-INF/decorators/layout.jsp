<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title" /></title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    
    <style>
        .nav-item.dropdown:hover .dropdown-menu { display: block; margin-top: 0; }
        .navbar-nav .nav-link { font-weight: 600; padding: 0.5rem 1rem !important; }
        .dropdown-item:hover { background-color: #f8f9fa; color: #e63946; }
        body { background-color: #f4f7f6; }
        .jumbotron { background: #fff; border-bottom: 1px solid #eee; margin-bottom: 0; padding: 2rem 1rem; }
        .content-wrapper { min-height: 600px; padding-top: 30px; padding-bottom: 50px; }
        footer { background: #343a40; color: #fff; padding: 20px 0; margin-top: 30px; }
    </style>
    <sitemesh:write property="head" />
</head>
<body>

<div class="jumbotron text-center">
    <h1 class="display-4" style="color: #333; font-weight: 800;">404X <span style="color: #e63946;">CLUB</span></h1>
    <p class="lead">GDJ97 백엔드 개발자 프로젝트</p>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse justify-content-center" id="mainNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">학원소개</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/professor">강사소개</a></li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#">교육과정</a>
                    <div class="dropdown-menu">
                        <c:choose>
                            <c:when test="${not empty clsList}">
                                <c:forEach var="cls" items="${clsList}">
									<a class="dropdown-item" href="${pageContext.request.contextPath}/class/category?code=${cls.category_code}">
									    ${cls.category_name}
									</a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <a class="dropdown-item" href="#">준비 중인 과정</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#">커뮤니티</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">공지사항</a>
                        <a class="dropdown-item" href="#">자유게시판</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#">학습지원</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">문의사항</a>
                        <a class="dropdown-item" href="#">FAQ</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container content-wrapper">
    <div class="row justify-content-center">
        <div class="col-lg-10 bg-white shadow-sm p-4 rounded">
            <sitemesh:write property="body" />
        </div>
    </div>
</div>

<footer class="text-center">
    <div class="container">
        <p class="mb-0">&copy; 2026 404X CLUB. All Rights Reserved.</p>
        <small>서울특별시 구로구 디지털로 | Tel: 02-111-2223</small>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>