<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<title>강사 관리 - 404 X CLUB</title>
<style>
html {
    overflow-y: scroll;
}
</style>
<div class="admin-content">

    <%-- 탭바 --%>
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/admin/host/request"
           class="tab-item ${activeTab == 'request' ? 'active' : 'inactive'}">권한요청</a>
        <a href="${pageContext.request.contextPath}/admin/host/list"
           class="tab-item ${activeTab == 'list' ? 'active' : 'inactive'}">등록된 호스트</a>
    </div>

    <div class="admin-page">

        <div class="search-bar">
            <input type="text" class="search-input" id="keyword" placeholder="이름으로 검색..." value="${searchContent}">
            <button class="search-btn" onclick="doSearch()">검색</button>
        </div>

        <c:choose>
            <%-- 권한요청 탭 --%>
            <c:when test="${activeTab == 'request'}">
                <div class="admin-actions-row">
                    <span class="admin-page-title">호스트 권한 요청</span>
                </div>
                <div class="admin-section" style="padding:0;">
                    <table class="data-table">
                        <thead>
                            <tr><th>이름</th><th>아이디</th><th>소개</th><th>가입일</th><th>관리</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="host" items="${hostList}">
                                <tr>
                                    <td>${host.user_name}</td>
                                    <td>${host.user_id}</td>
                                    <td>${host.host_intro}</td>
                                    <td><fmt:formatDate value="${host.user_join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td class="btn-action-row" style="display:flex;gap:6px;">
                                        <button class="btn btn-black btn-sm" onclick="approveOne('${host.user_id}')">승인</button>
                                        <button class="btn btn-ghost btn-sm" onclick="rejectOne(${host.user_id})">거절</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>

            <%-- 등록된 호스트 탭 --%>
            <c:otherwise>
                <div class="admin-page-title" style="margin-bottom:12px;">호스트 목록</div>
                <div class="admin-section" style="padding:0;">
                    <table class="data-table">
                        <thead>
                            <tr><th>이름</th><th>아이디</th><th>소개</th><th>가입일</th><th>관리</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="host" items="${hostList}">
                                <tr>
                                    <td>${host.user_name}</td>
                                    <td style="color:#888;">${host.user_id}</td>
                                    <td>${host.host_intro}</td>
                                    <td><fmt:formatDate value="${host.user_join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td style="display:flex;gap:6px;">
                                        <button class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/mypage/instructor/settlement?target_id=${host.user_id}'">정산</button>
                                        <button class="btn btn-ghost btn-sm" onclick="deleteHost('${host.user_id}')">해제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
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
var ctx = '${pageContext.request.contextPath}';
function doSearch(){ location.href=ctx+'/admin/host/${activeTab}?keyword='+encodeURIComponent($('#keyword').val()); }
function approveOne(id){
    showConfirm('승인하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/approve', {user_id: id}, 'POST', function(res){ 
            if(res.success) location.reload(); 
        });
    });
}
function rejectOne(id){
    showConfirm('거절하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/reject', {user_id: id}, 'POST', function(res){ 
            if(res.success) location.reload(); 
        });
    });
}
function deleteHost(id){
    showConfirm('강사권한을 해제하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/delete', {user_id: id}, 'POST', function(res){ 
            if(res.success) location.reload(); 
        });
    });
}
</script>
