<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>홈 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="container">

    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">

        <%-- BEST 강의 섹션 --%>
        <section class="card">
            <h2 style="font-size:22px;font-weight:900;margin-bottom:20px;font-style:italic;">BEST 강의</h2>

            <c:choose>
                <c:when test="${not empty bestClassList}">
                    <c:forEach var="lec" items="${bestClassList}">
                        <div style="margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #f0f0f0;">
                            <div style="background:#eee; height:150px; border-radius:8px; margin-bottom:10px;"></div>
                            <div style="font-size:12px; color:#888;">${lec.userName}</div>
                            <div style="font-size:14px; font-weight:600; margin-top:4px;">${lec.clsTitle}</div>
                        </div>
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
                    내 강의실 <a href="${pageContext.request.contextPath}/mypage/classroom" style="font-size:12px;font-weight:400;color:#888;margin-left:8px;">수강현황</a>
                </h3>
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser and not empty myClassList}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>강의제목</th>
                                    <th>강사이름</th>
                                    <th>진도율</th>
                                    <th>남은 기간</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cls" items="${myClassList}">
                                    <tr>
                                        <td>${cls.clsTitle}</td>
                                        <td>${cls.userName}</td>
                                        <td>${cls.progress}%</td>
                                        <td>${cls.remainDay}일</td>
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
                            <a href="${pageContext.request.contextPath}/user/login" style="color:#e63946;">로그인이 필요합니다.</a>
                        </p>
                    </c:otherwise>
                </c:choose>
            </section>

        </div>
    </div>

</div>
</main>

