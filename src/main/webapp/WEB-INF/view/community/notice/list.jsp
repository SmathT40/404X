<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>공지사항 - 404 X CLUB</title>

<main class="content-area">
<div class="container" style="max-width:900px;">

    <div class="tab-bar" style="justify-content:center;margin-bottom:28px;">
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=0" class="tab-item active">공지사항</a>
        <a href="${pageContext.request.contextPath}/community/board/list?boardid=1" class="tab-item">자유게시판</a>
    </div>

    <div class="search-bar">
        <input type="text" class="search-input" id="keyword" placeholder="검색어를 입력해 주세요."
               value="${param.searchcontent}"
               onkeypress="if(event.keyCode==13) doSearch()">
        <button class="search-btn" onclick="doSearch()">Search</button>
    </div>

    <c:choose>
        <c:when test="${not empty noticeList}">
            <c:forEach var="post" items="${noticeList}">
                <div onclick="location.href='${pageContext.request.contextPath}/community/board/detail?boardid=0&board_no=${post.board_no}'"
                     style="border-bottom:1px solid #eee;padding:20px 8px;cursor:pointer;">
                    <div style="font-size:12px;color:#e63946;margin-bottom:6px;">${post.board_reg_date}</div>
                    <div style="display:flex;justify-content:space-between;align-items:center;">
                        <div>
                            <div style="font-size:15px;font-weight:600;margin-bottom:6px;">${post.board_title}</div>
                            <div style="font-size:13px;color:#888;">${post.board_content}</div>
                        </div>
                        <span style="font-size:18px;color:#aaa;margin-left:16px;">&#8599;</span>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div style="text-align:center;color:#aaa;padding:40px;">등록된 공지사항이 없습니다.</div>
        </c:otherwise>
    </c:choose>

    <c:if test="${sessionScope.loginUser.user_role == 2}">  
        <div style="text-align:right;margin-top:12px;">
            <a href="${pageContext.request.contextPath}/community/board/form?boardid=0"
               class="btn btn-black btn-sm">글쓰기</a>
        </div>
     </c:if>  

</div>
</main>

<script>
function doSearch(){
    var keyword = $('#keyword').val().trim();
    location.href = '${pageContext.request.contextPath}/community/board/list?boardid=0&searchtype=board_title&searchcontent=' + keyword;
}
</script>