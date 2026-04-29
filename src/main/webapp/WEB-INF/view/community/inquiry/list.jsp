<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>1:1 문의 - 404 X CLUB</title>

<main class="content-area">
<div class="container" style="max-width:900px;">

    <div class="tab-bar" style="justify-content:center;margin-bottom:28px;">
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=3" class="tab-item active">문의사항</a>
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=2" class="tab-item">FAQ</a>
    </div>

    <table class="data-table">
        <thead>
            <tr><th>NO</th><th>제목</th><th>첨부파일</th><th>작성자</th><th>등록일</th><th>조회수</th><th>답변상태</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty inquiryList}">
                    <c:forEach var="post" items="${inquiryList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/community/board/detail?boardid=3&board_no=${post.board_no}'"
                            style="cursor:pointer;">
                            <td>${post.board_no}</td>
                            <td>${post.board_title}</td>
                            <td style="text-align:center;">
                                <c:if test="${not empty post.fileurl}">&#128196;</c:if>
                            </td>
                            <td>${post.user_id}</td>
                            <td>${post.board_reg_date}</td>
                            <td>${post.board_cnt}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${post.board_status == 1}">
                                        <span class="badge badge-gray">답변 완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-blue">답변 대기</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="7" style="text-align:center;color:#aaa;padding:30px;">문의 내역이 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div style="text-align:right;margin-top:12px;">
        <c:choose>
    <c:when test="${not empty sessionScope.loginUser}">
        <a href="${pageContext.request.contextPath}/community/board/form?boardid=1" class="btn btn-black btn-sm">글쓰기</a>
    </c:when>
    <c:otherwise>
        <a href="#" onclick="showAlert('로그인이 필요합니다.'); return false;" class="btn btn-black btn-sm">글쓰기</a>
    </c:otherwise>
</c:choose>
    </div>
    <jsp:include page="/WEB-INF/view/common/pagination.jsp">
    <jsp:param name="currentPage" value="${currentPage}"/>
    <jsp:param name="totalPage"   value="${totalPage}"/>
    <jsp:param name="pageUrl"     value="/404X/community/board/list?boardid=3&pageNum="/>
</jsp:include>
</div>
</main>
