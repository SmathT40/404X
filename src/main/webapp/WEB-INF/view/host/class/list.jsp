<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>내 강의 관리 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<style>
html {
    overflow-y: scroll;
}
</style>
<div class="admin-content">
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/host/class/status" class="tab-item inactive">클래스 현황</a>
        <a href="${pageContext.request.contextPath}/host/class/list"   class="tab-item active">전체 클래스</a>
    </div>

    <div class="admin-page">

        <div class="search-bar">
            <input type="text" class="search-input" id="keyword" placeholder="강의명으로 검색..." value="${param.keyword}">
            <button class="search-btn" onclick="doSearch()">검색</button>
        </div>

        <div class="admin-actions-row">
            <span class="admin-page-title">전체 클래스</span>
            <div style="display:flex;gap:8px;">
                <button class="btn btn-ghost btn-sm" onclick="doEdit()">수정</button>
                <button class="btn btn-ghost btn-sm" onclick="deleteSelected()">선택삭제</button>
            </div>
        </div>

        <div class="admin-section" style="padding:0;">
            <table class="data-table" id="classList">
                <thead>
                    <tr><th><input type="checkbox" class="chk-all"></th><th>제목</th><th>강사명</th><th>가격</th><th>등록일</th><th>승인여부</th></tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty classList}">
                            <c:forEach var="cls" items="${classList}">
                                <tr>
                                    <td><input type="checkbox" class="chk-item" value="${cls.class_id}"></td>
                                    <td><a href="${pageContext.request.contextPath}/class/detail?id=${cls.class_id}">${cls.cls_title}</a></td>
                                    <td>${cls.user_name}</td>
                                    <td><fmt:formatNumber value="${cls.cls_price}" pattern="#,###"/>원</td>
                                    <td><fmt:formatDate value="${cls.cls_reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${cls.cls_status == '-1'}"><span class="badge badge-red">삭제</span></c:when>
                                            <c:when test="${cls.cls_status == '1'}"><span class="badge badge-green">승인</span></c:when>
                                            <c:otherwise><span class="badge badge-gray">보류</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">등록된 클래스가 없습니다.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <div style="display:flex;justify-content:flex-end;gap:12px;margin-top:20px;">
            <a href="${pageContext.request.contextPath}/host/class/classForm"   class="btn btn-black">클래스등록</a>
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
function doSearch(){ location.href='${pageContext.request.contextPath}/host/class/list?keyword=' + encodeURIComponent($('#keyword').val()); }
function doEdit(){
    var ids = [];
    $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(ids.length !== 1){ showAlert('수정할 클래스를 1개 선택해주세요.'); return; }
    location.href = '${pageContext.request.contextPath}/host/class/updateform?class_id=' + ids[0];
}
function deleteSelected(){
    var ids = [];
    $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('삭제할 항목을 선택해주세요.'); return; }
    showConfirm('선택한 클래스를 삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/host/class/deleteMulti',
            {classIds: ids.join(',')}, 'POST',
            function(res){ if(res.success) location.reload(); });
    });
}
$(document).ready(function() {
    const msg = "${completeMsg}";
    
    if (msg) {
        openModal('등록 완료', msg, function() {
        }, false);
    }
});
</script>
