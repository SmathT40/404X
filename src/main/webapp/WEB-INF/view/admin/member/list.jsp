<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>회원 관리 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="admin-content">
    <div class="admin-page">
        <div style="font-size:15px;font-weight:600;margin-bottom:20px;">회원관리</div>

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
    					<c:when test="${not empty userList}">
        					<c:forEach var="mem" items="${userList}">
            					<tr>
                					<td><input type="checkbox" class="chk-item" value="${mem.user_id}" data-email="${mem.user_email}"></td>
                					<td>${mem.user_name}</td>
                					<td>${mem.user_id}</td>
                					<td>${mem.user_email}</td>
                					<td>${mem.class_count}</td>
                					<td><fmt:formatDate value="${mem.user_join_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                					<td style="display:flex;gap:6px;">
                    					<button class="btn btn-ghost btn-sm" onclick="withdrawMember('${mem.user_id}')">탈퇴</button>
                					</td>
            					</tr>
        					</c:forEach>
    					</c:when>
    					<c:otherwise>
        					<tr><td colspan="7" style="text-align:center;color:#aaa;padding:30px;">회원이 없습니다.</td></tr>
    					</c:otherwise>
					</c:choose>
                </tbody>
            </table>
        </div>

        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${currentPage}"/>
            <jsp:param name="totalPage"   value="${totalPage}"/>
            <jsp:param name="pageUrl"     value="${pageContext.request.contextPath}/admin/member/list?keyword=${keyword}&amp;page="/>
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
<script>
var ctx = '${pageContext.request.contextPath}';
function doSearch(){ location.href=ctx+'/admin/member/list?keyword='+encodeURIComponent($('#keyword').val()); }
function sendMail(){
    var emails=[]; 
    $('.chk-item:checked').each(function(){ 
        emails.push($(this).data('email')); 
    });
    if(!emails.length){ showAlert('메일을 발송할 회원을 선택해주세요.'); return; }
    location.href = ctx + '/admin/mail/form?emails=' + emails.join(',');
}
function deleteSelected(){
    var ids=[]; $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('삭제할 항목을 선택해주세요.'); return; }
    showConfirm('선택한 회원을 삭제하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/member/deleteMulti',{user_ids:ids.join(',')},'POST', function(res){ if(res.success) location.reload(); });
    });
}
function withdrawMember(userId){
    showConfirm('해당 회원을 탈퇴 처리하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/member/withdraw',{user_id:userId},'POST', function(res){ if(res.success) location.reload(); });
    });
}
</script>
