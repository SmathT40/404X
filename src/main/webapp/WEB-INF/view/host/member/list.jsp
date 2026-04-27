<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>수강생 목록 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="admin-content">
    <div class="admin-page">
        <div style="font-size:15px;font-weight:600;margin-bottom:20px;">수강생 확인</div>

        <div class="search-bar">
            <input type="text" class="search-input" id="keyword" placeholder="이름으로 검색..." value="${param.keyword}">
            <button class="search-btn" onclick="doSearch()">검색</button>
        </div>

        <div style="display:flex;justify-content:flex-end;gap:8px;margin-bottom:12px;">
            <button class="btn btn-primary btn-sm" onclick="sendMail()">메일발송</button>
            <button class="btn btn-ghost btn-sm" onclick="deleteSelected()">선택삭제</button>
        </div>

        <div class="admin-section" style="padding:0;">
            <table class="data-table" id="memberTable">
                <thead>
                    <tr><th><input type="checkbox" class="chk-all"></th><th>이름</th><th>아이디</th><th>이메일</th><th>수강수</th><th>가입일</th><th>관리</th></tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty memberList}">
                            <c:forEach var="mem" items="${memberList}">
                                <tr>
                                    <td><input type="checkbox" class="chk-item" value="${mem.userId}"></td>
                                    <td>${mem.userName}</td>
                                    <td>${mem.userId}</td>
                                    <td>${mem.userEmail}</td>
                                    <td>${mem.classCount}</td>
                                    <td>${mem.userJoinDate}</td>
                                    <td>
                                        <button class="btn btn-ghost btn-sm" onclick="cancelEnroll('${mem.userId}')">수강취소</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="7" style="text-align:center;color:#aaa;padding:30px;">수강생이 없습니다.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${currentPage}"/>
            <jsp:param name="totalPage"   value="${totalPage}"/>
            <jsp:param name="pageUrl"     value="/host/member/list?page="/>
        </jsp:include>
    </div>
</div>
</div>

<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">알림</div>
        <div class="modal-body"  id="modalBody"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn"  onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
function doSearch(){ location.href='${pageContext.request.contextPath}/host/member/list?keyword='+encodeURIComponent($('#keyword').val()); }
function sendMail(){
    var ids=[];
    $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('메일을 발송할 회원을 선택해주세요.'); return; }
    showAlert('메일이 발송되었습니다.');
}
function deleteSelected(){
    var ids=[];
    $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('삭제할 항목을 선택해주세요.'); return; }
    showConfirm('선택한 수강생을 삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/host/member/deleteMulti',{userIds:ids.join(',')}, 'POST',
            function(res){ if(res.success) location.reload(); });
    });
}
function cancelEnroll(userId){
    showConfirm('수강을 취소하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/host/member/cancelEnroll',{userId:userId},'POST',
            function(res){ if(res.success) location.reload(); });
    });
}
</script>
