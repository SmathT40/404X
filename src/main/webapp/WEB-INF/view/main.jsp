<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>홈 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
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
<main class="content-area">
<div class="container">

    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">

        <%-- BEST 강의 섹션 --%>
        <section class="card">
            <h2 style="font-size:22px;font-weight:900;margin-bottom:20px;font-style:italic;">BEST 강의</h2>

            <c:choose>
                <c:when test="${not empty bestClassList}">
                    <c:forEach var="cls" items="${bestClassList}">
                    <a href="${pageContext.request.contextPath}/class/detail?id=${cls.class_id}">
                        <div style="margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #f0f0f0; ">
                            <div style="background:#eee; border-radius:8px; margin-bottom:10px;"><img src="${cls.cls_thumbnail}" style="width:100%;height:100%;object-fit:cover;"></div>
                            <div style="font-size:12px; color:#888;">${cls.user_name}</div>
                            <div style="font-size:14px; font-weight:600; margin-top:4px;">${cls.cls_title}</div>
                        </div>
                    </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <%-- 더미 데이터 --%>
                    <div style="margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #f0f0f0;">
                        <div style="background:#ddd; height:150px; border-radius:8px; margin-bottom:10px;"></div>
                        <div style="font-size:12px; color:#888;">강의1</div>
                        <div style="font-size:13px; margin-top:4px;">BEST강의 정보가 들어가는 영역입니다.</div>
                    </div>
                    <div>
                        <div style="background:#ddd; height:150px; border-radius:8px; margin-bottom:10px;"></div>
                        <div style="font-size:12px; color:#888;">강의2</div>
                        <div style="font-size:13px; margin-top:4px;">BEST강의 정보가 들어가는 영역입니다.</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <%-- 우측 섹션 (공지사항 + 내강의실) --%>
        <div style="display:flex; flex-direction:column; gap:20px;">

            <%-- 공지사항 --%>
            <section class="card">
                <h3 style="font-size:18px;font-weight:700;margin-bottom:16px;">공지사항</h3>
                <c:choose>
                    <c:when test="${not empty recentNoticeList}">
                        <c:forEach var="notice" items="${recentNoticeList}">
                            <div style="font-size:13px; color:#444; margin-bottom:8px;">
                                <a href="${pageContext.request.contextPath}/community/board/detail?boardid=0&board_no=${notice.board_no}">
                                    ${notice.board_title}
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="font-size:13px; color:#888;">선택된 공지사항이 들어가는 영역입니다.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <%-- 내 강의실 (로그인 사용자만) --%>
            <section class="card">
                <h3 style="font-size:18px;font-weight:700;margin-bottom:16px;">
                    수강현황 <a href="${pageContext.request.contextPath}/mypage/classroom" style="font-size:12px;font-weight:400;color:#888;margin-left:8px;">강의실로</a>
                </h3>
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser and not empty myClassList}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>강의제목</th>
                                    <th>강사이름</th>
                                    <th>진도율</th>
                                    <th>강의 만료일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cls" items="${myClassList}">
                                    <tr>
                                        <td>${cls.cls_title}</td>
                                        <td>${cls.user_name}</td>
                                        <td>${cls.progress}%</td>
                                        <td>${cls.cls_end_date}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="display:grid; grid-template-columns:repeat(4,1fr); gap:8px; font-size:12px; color:#aaa; margin-bottom:12px;">
                            <span>강의제목</span><span>강사이름</span><span>진도율</span><span>남은 기간</span>
                        </div>
                        <p style="font-size:13px; color:#aaa; text-align:center; padding:10px 0;">
                        	<c:if test="${not empty sessionScope.loginUser}"><a style="color:#e63946;">수강정보가 없습니다.</a></c:if>
                        	<c:if test="${empty sessionScope.loginUser}"><a href="${pageContext.request.contextPath}/user/login" style="color:#e63946;">로그인이 필요합니다.</a></c:if>
                        </p>
                    </c:otherwise>
                </c:choose>
            </section>
           	<section class="card">
                <h3 style="font-size:18px;font-weight:700;margin-bottom:16px;">
                    광고
                    <img src="https://item.kakaocdn.net/do/218bdb82c9a7456ee2080fe14a464292934a8bea49f711d785ad9144e9c20713">
                </h3>
			</section>
        </div>
    </div>

</div>
</main>

