<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
            <input type="text" class="search-input" id="keyword" placeholder="이름으로 검색..." value="${param.keyword}">
            <button class="search-btn" onclick="doSearch()">검색</button>
        </div>

        <c:choose>
            <%-- 권한요청 탭 --%>
            <c:when test="${activeTab == 'request'}">
                <div class="admin-actions-row">
                    <span class="admin-page-title">호스트 권한 요청</span>
                    <div style="display:flex;gap:8px;">
                        <button class="btn btn-primary btn-sm" onclick="approveSelected()">선택승인</button>
                        <button class="btn btn-ghost btn-sm" onclick="rejectSelected()">선택거절</button>
                    </div>
                </div>
                <div class="admin-section" style="padding:0;">
                    <table class="data-table" id="hostTable">
                        <thead>
                            <tr><th><input type="checkbox" class="chk-all"></th><th>이름</th><th>아이디</th><th>과목</th><th>신청일</th><th>승인여부</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="req" items="${hostList}">
                                <tr>
                                    <td><input type="checkbox" class="chk-item" value="${req.hostReqId}"></td>
                                    <td>${req.userName}</td>
                                    <td>${req.userId}</td>
                                    <td>${req.categoryName}</td>
                                    <td>${req.reqDate}</td>
                                    <td class="btn-action-row" style="display:flex;gap:6px;">
                                        <button class="btn btn-black btn-sm" onclick="approveOne(${req.hostReqId})">승인</button>
                                        <button class="btn btn-ghost btn-sm" onclick="rejectOne(${req.hostReqId})">거절</button>
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
                        <tbody>
                            <c:forEach var="host" items="${hostList}">
                                <tr>
                                    <td>${host.userName}</td>
                                    <td style="color:#888;">${host.userId}</td>
                                    <td>${host.categoryName}</td>
                                    <td>${host.approveDate}</td>
                                    <td style="display:flex;gap:6px;">
                                        <button class="btn btn-black btn-sm" onclick="location.href='${pageContext.request.contextPath}/admin/host/edit?id=${host.userId}'">수정</button>
                                        <button class="btn btn-ghost btn-sm" onclick="deleteHost('${host.userId}')">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <jsp:include page="/WEB-INF/views/common/pagination.jsp">
            <jsp:param name="currentPage" value="${currentPage}"/>
            <jsp:param name="totalPage"   value="${totalPage}"/>
            <jsp:param name="pageUrl"     value="/admin/host/${activeTab}?page="/>

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
        ajaxRequest(ctx+'/admin/host/approve',{hostReqId:id},'POST', function(res){ if(res.success) location.reload(); });
    });
}
function rejectOne(id){
    showConfirm('거절하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/reject',{hostReqId:id},'POST', function(res){ if(res.success) location.reload(); });
    });
}
function approveSelected(){
    var ids=[]; $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('승인할 항목을 선택해주세요.'); return; }
    showConfirm('선택한 항목을 승인하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/approveMulti',{hostReqIds:ids.join(',')},'POST', function(res){ if(res.success) location.reload(); });
    });
}
function rejectSelected(){
    var ids=[]; $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('거절할 항목을 선택해주세요.'); return; }
    showConfirm('선택한 항목을 거절하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/rejectMulti',{hostReqIds:ids.join(',')},'POST', function(res){ if(res.success) location.reload(); });
    });
}
function deleteHost(userId){
    showConfirm('호스트를 삭제하시겠습니까?', function(){
        ajaxRequest(ctx+'/admin/host/delete',{userId:userId},'POST', function(res){ if(res.success) location.reload(); });
    });
}
</script>
