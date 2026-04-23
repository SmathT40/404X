<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>내 게시글 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <div class="mypage-tab-bar">
        <a href="${pageContext.request.contextPath}/mypage"           class="tab-item">마이페이지</a>
        <a href="${pageContext.request.contextPath}/mypage/classroom" class="tab-item">내강의실</a>
        <a href="${pageContext.request.contextPath}/mypage/myPost"    class="tab-item active">내가쓴글</a>
        <a href="${pageContext.request.contextPath}/mypage/payment"   class="tab-item">결제내역</a>
    </div>

    <h2 class="section-title">내가쓴글</h2>

    <%-- 나의 게시글 --%>
    <div style="margin-bottom:40px;">
        <div style="font-weight:600;margin-bottom:14px;">나의 게시글</div>
        <table class="data-table">
            <thead>
                <tr><th>게시글번호</th><th>게시글이름</th><th>작성게시판</th><th>작성날짜</th></tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myPostList}">
                        <c:forEach var="post" items="${myPostList}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/community/free/detail?id=${post.boardNo}'" style="cursor:pointer;">
                                <td>${post.boardNo}</td>
                                <td>${post.boardTitle}</td>
                                <td>${post.boardCategory}</td>
                                <td>${post.boardRegDate}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="4" style="text-align:center;color:#aaa;padding:30px;">작성한 게시글이 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <jsp:include page="/WEB-INF/views/common/pagination.jsp">
            <jsp:param name="currentPage" value="${postPage}"/>
            <jsp:param name="totalPage"   value="${postTotalPage}"/>
            <jsp:param name="pageUrl"     value="/mypage/myPost?type=post&page="/>
    </div>

    <%-- 나의 댓글 --%>
    <div>
        <div style="font-weight:600;margin-bottom:14px;">나의 댓글</div>
        <table class="data-table">
            <thead>
                <tr><th>게시글번호</th><th>게시글이름</th><th>작성게시판</th><th>작성날짜</th></tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myCommentList}">
                        <c:forEach var="cmt" items="${myCommentList}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/community/free/detail?id=${cmt.boardId}'" style="cursor:pointer;">
                                <td>${cmt.boardNo}</td>
                                <td>${cmt.title}</td>
                                <td>${cmt.boardCategory}</td>
                                <td>${cmt.regDate}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="4" style="text-align:center;color:#aaa;padding:30px;">작성한 댓글이 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <jsp:include page="/WEB-INF/views/common/pagination.jsp">
            <jsp:param name="currentPage" value="${cmtPage}"/>
            <jsp:param name="totalPage"   value="${cmtTotalPage}"/>
            <jsp:param name="pageUrl"     value="/mypage/myPost?type=comment&page="/>
    </div>

</div>
</main>
