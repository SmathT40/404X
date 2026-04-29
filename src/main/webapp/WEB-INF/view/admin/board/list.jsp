<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>게시판 관리 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="admin-content">

    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/admin/board/list"
           class="tab-item ${activeTab == 'list' ? 'active' : 'inactive'}">전체 게시글</a>
    </div>

    <div class="admin-page">

        <c:choose>
            <%-- 게시판 설정 탭 --%>
            <c:when test="${activeTab == 'setting'}">
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">

                    <div>
                        <div class="admin-section">
                            <div class="admin-section-header">
                                <span class="admin-section-title">상단 탭</span>
                                <span style="font-size:11px;color:#aaa;">클릭해서 선택</span>
                            </div>
                            <c:forEach var="tab" items="${gnbTabList}">
                                <div style="display:flex;align-items:center;justify-content:space-between;padding:12px 0;border-bottom:1px solid #f5f5f5;font-size:13px;">
                                    <span>${tab.tabName}</span>
                                    <span style="color:#aaa;font-size:12px;">카테고리 ${tab.catCount}개</span>
                                    <button class="btn btn-ghost btn-sm" onclick="location.href='${pageContext.request.contextPath}/admin/board/editTab?id=${tab.tabId}'">수정</button>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="admin-section" style="margin-top:16px;">
                            <div class="admin-section-title" style="margin-bottom:14px;">카테고리</div>
                            <c:forEach var="cat" items="${categoryList}">
                                <div style="display:flex;align-items:center;justify-content:space-between;padding:12px 0;border-bottom:1px solid #f5f5f5;font-size:13px;">
                                    <span>${cat.catName}</span>
                                    <span style="color:#aaa;font-size:12px;">게시판 ${cat.boardCount}개</span>
                                    <button class="btn btn-ghost btn-sm" onclick="location.href='${pageContext.request.contextPath}/admin/board/editCat?id=${cat.catId}'">수정</button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="admin-section">
                        <div class="admin-section-header">
                            <span class="admin-section-title">게시판 설정</span>
                            <button class="btn btn-ghost btn-sm" onclick="addBoard()">+</button>
                        </div>
                        <c:forEach var="board" items="${boardList}">
                            <div style="display:flex;align-items:center;justify-content:space-between;padding:12px 0;border-bottom:1px solid #f5f5f5;font-size:13px;">
                                <span>${board.boardName}</span>
                                <button class="btn btn-ghost btn-sm" onclick="deleteBoard(${board.boardId})">삭제</button>
                            </div>
                        </c:forEach>

                        <div style="margin-top:16px;">
                            <textarea id="boardEditContent" class="form-control" rows="3"
                                      placeholder="수정할 내용을 입력하는 공간입니다."
                                      style="resize:none;height:80px;"></textarea>
                            <div style="text-align:right;margin-top:8px;">
                                <button class="btn btn-black btn-sm" onclick="saveBoard()">저장</button>
                            </div>
                        </div>
                    </div>

                </div>
            </c:when>

            <%-- 전체 게시글 탭 --%>
            <c:otherwise>
                <div class="search-bar">
                    <input type="text" class="search-input" id="keyword" placeholder="제목으로 검색..." value="${param.keyword}">
                    <button class="search-btn" onclick="doSearch()">검색</button>
                </div>

                <div class="admin-actions-row">
                    <span class="admin-page-title">전체 게시글</span>
                    <button class="btn btn-ghost btn-sm" onclick="deleteSelected()">선택삭제</button>
                </div>

                <div class="admin-section" style="padding:0;">
                    <table class="data-table" id="boardTable">
                        <thead>
                            <tr>
                                <th><input type="checkbox" class="chk-all"></th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성게시판</th>
                                <th>작성일</th>
                                <th>답변상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="post" items="${postList}">
                                <tr>
                                    <td><input type="checkbox" class="chk-item" value="${post.board_no}"></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/community/board/detail?boardid=${post.board_type}&board_no=${post.board_no}"
                                           style="color:#333;text-decoration:none;">
                                            ${post.board_title}
                                        </a>
                                    </td>
                                    <td>${post.user_id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${post.board_type == 0}">공지사항</c:when>
                                            <c:when test="${post.board_type == 1}">자유게시판</c:when>
                                            <c:when test="${post.board_type == 3}">문의사항</c:when>
                                            <c:when test="${post.board_type == 2}">FAQ</c:when>
                                        </c:choose>
                                    </td>
                                    <td>${post.board_reg_date}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${post.board_type == 3 && post.board_status == 0}">
                                                <span class="badge badge-gray">답변 대기</span>
                                            </c:when>
                                            <c:when test="${post.board_type == 3 && post.board_status == 1}">
                                                <span class="badge badge-blue">답변 완료</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex;gap:6px;align-items:center;">
                                        <c:choose>
                                            <c:when test="${post.board_type == 0}">
                                                <button class="btn btn-black btn-sm" onclick="location.href='${pageContext.request.contextPath}/community/board/form?boardid=0&board_no=${post.board_no}'">수정</button>
                                                <button class="btn btn-ghost btn-sm" onclick="deletePost(${post.board_no})">삭제</button>
                                            </c:when>
                                            <c:when test="${post.board_type == 3}">
                                                <button class="btn btn-black btn-sm" onclick="location.href='${pageContext.request.contextPath}/community/board/form?boardid=3&board_no=${post.board_no}'">수정</button>
                                                <button class="btn btn-ghost btn-sm" onclick="deletePost(${post.board_no})">삭제</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-black btn-sm" onclick="location.href='${pageContext.request.contextPath}/community/board/form?boardid=1&board_no=${post.board_no}'">수정</button>
                                                <button class="btn btn-ghost btn-sm" onclick="deletePost(${post.board_no})">삭제</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <jsp:include page="/WEB-INF/view/common/pagination.jsp">
                    <jsp:param name="currentPage" value="${currentPage}"/>
                    <jsp:param name="totalPage"   value="${totalPage}"/>
                    <jsp:param name="pageUrl"     value="/404X/admin/board/list?pageNum="/>
                </jsp:include>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<script>
var ctx='${pageContext.request.contextPath}';
function doSearch(){ location.href=ctx+'/admin/board/list?keyword='+encodeURIComponent($('#keyword').val()); }
function saveBoard(){ ajaxRequest(ctx+'/admin/board/save',{content:$('#boardEditContent').val()},'POST',function(res){ if(res.success) showAlert('저장되었습니다.'); }); }
function deleteBoard(id){ showConfirm('삭제하시겠습니까?',function(){ ajaxRequest(ctx+'/admin/board/deleteBoard',{boardId:id},'POST',function(res){ if(res.success) location.reload(); }); }); }
function addBoard(){ showAlert('게시판 추가 기능을 구현하세요.'); }
function deletePost(id){ showConfirm('삭제하시겠습니까?',function(){ ajaxRequest(ctx+'/admin/board/deletePost',{board_no:id},'POST',function(res){ if(res.success) location.reload(); }); }); }
function deleteSelected(){
    var ids=[]; $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('삭제할 항목을 선택해주세요.'); return; }
    showConfirm('선택 항목을 삭제하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/board/deleteMulti',{board_nos:ids.join(',')},'POST',function(res){ if(res.success) location.reload(); });
    });
}
</script>