<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 관리 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<style>
html {
    overflow-y: scroll;
}
#classTable {
    width: 100%;
    border-collapse: collapse;
}
#classTable th:nth-child(1) { width: 40px; }
#classTable th:nth-child(2) { width: auto; text-align: center; }
#classTable th:nth-child(3) { width: 100px; }
#classTable th:nth-child(4) { width: 120px; }
#classTable th:nth-child(5) { width: 160px; }
#classTable th:nth-child(6) { width: 140px; }

.search-bar {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 20px;
}
.search-select {
    padding: 6px 32px 6px 16px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 20px;
    background-color: #fff;
    color: #333;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23999' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='m6 9 6 6 6-6'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 12px center;
    transition: border-color 0.2s;
}
.search-select:focus {
    outline: none;
    border-color: #000;
}
.search-input {
    padding: 6px 16px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 20px;
    width: 200px;
}
.admin-page {
    background: #fff;
    border-radius: 12px;
    padding: 24px;
    border: 1px solid #eee;
    margin-top: 20px;
}
.admin-actions-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 16px;
}
.admin-page-title {
    font-size: 15px;
    font-weight: 700;
    margin-right: auto;
}
</style>

<div class="admin-tab-bar">
    <a href="${pageContext.request.contextPath}/admin/class/list?status=0"
        class="tab-item ${param.status == '0' ? 'active' : ''}">클래스 승인 요청</a>
    <a href="${pageContext.request.contextPath}/admin/class/list?status=1"
        class="tab-item ${param.status == '1' ? 'active' : ''}">승인된 클래스</a>
    <a href="${pageContext.request.contextPath}/admin/class/list?status=-1"
        class="tab-item ${param.status == '-1' ? 'active' : ''}">삭제된 클래스</a>
</div>

<div class="admin-page">
    <div class="search-bar">
        <select id="searchType" class="search-select">
            <option value="title" ${searchType == 'title' ? 'selected' : ''}>클래스명</option>
            <option value="instructor" ${searchType == 'instructor' ? 'selected' : ''}>강사명</option>
        </select>
        <input type="text" class="search-input" id="searchContent"
               placeholder="검색어를 입력하세요..." value="${searchContent}">
        <button class="search-btn" onclick="doSearch()">검색</button>
    </div>

    <div class="admin-actions-row">
        <span class="admin-page-title">전체 클래스</span>
        <button class="btn btn-ghost btn-sm" onclick="deleteSelected()">선택삭제</button>
        <button class="btn btn-ghost btn-sm" onclick="approveSelected()">선택승인</button>
        <button class="btn btn-ghost btn-sm" onclick="rejectSelected()">선택보류</button>
    </div>

    <div class="admin-section" style="padding:0;">
        <table class="data-table" id="classTable">
            <thead>
                <tr>
                    <th><input type="checkbox" class="chk-all"></th>
                    <th>클래스명</th>
                    <th>강사명</th>
                    <th>가격</th>
                    <th>신청일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty classList}">
                        <c:forEach var="cls" items="${classList}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/class/detail?id=${cls.class_id}'" style="cursor:pointer;">
                                <td><input type="checkbox" class="chk-item" value="${cls.class_id}" onclick="event.stopPropagation();"></td>
                                <td>${cls.cls_title}</td>
                                <td>${cls.user_name}</td>
                                <td><fmt:formatNumber value="${cls.cls_price}" pattern="#,###"/>원</td>
                                <td><fmt:formatDate value="${cls.cls_reg_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td style="display:flex;gap:6px;">
                                    <c:choose>
                                        <c:when test="${cls.cls_status == 0}">
                                            <button class="btn btn-black btn-sm" onclick="event.stopPropagation(); approveOne(${cls.class_id})">승인</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-black btn-sm" onclick="event.stopPropagation(); location.href='${pageContext.request.contextPath}/host/class/updateform?class_id=${cls.class_id}'">수정</button>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${cls.cls_status == -1}">
                                            <button class="btn btn-ghost btn-sm" onclick="event.stopPropagation(); rejectOne(${cls.class_id})">보류</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-ghost btn-sm" onclick="event.stopPropagation(); deleteOne(${cls.class_id})">삭제</button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr class="empty-row">
                            <td colspan="6">
                                <div class="empty-msg">
                                    <p style="text-align:center;">조회된 클래스 정보가 없습니다.</p>
                                </div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">알림</div>
        <div class="modal-body"  id="modalBody"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn" onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
var ctx = '${pageContext.request.contextPath}';

function doSearch() {
    const type = $('#searchType').val();
    const content = $('#searchContent').val();
    const status = '${param.status}';
    let url = ctx + '/admin/class/list?searchType=' + type + '&searchContent=' + encodeURIComponent(content);
    if (status) url += '&status=' + status;
    location.href = url;
}

function approveOne(id) {
    showConfirm('승인하시겠습니까?', function() {
        ajaxRequest(ctx + '/admin/class/approve', {classIds: id}, 'POST', function(res) { if (res.success) location.reload(); });
    });
}
function rejectOne(id) {
    showConfirm('보류하시겠습니까?', function() {
        ajaxRequest(ctx + '/admin/class/reject', {classIds: id}, 'POST', function(res) { if (res.success) location.reload(); });
    });
}
function deleteOne(id) {
    showConfirm('삭제하시겠습니까?', function() {
        ajaxRequest(ctx + '/admin/class/delete', {classIds: id}, 'POST', function(res) { if (res.success) location.reload(); });
    });
}
function approveSelected() {
    var ids = []; $('.chk-item:checked').each(function() { ids.push($(this).val()); });
    if (!ids.length) { showAlert('승인할 항목을 선택해주세요.'); return; }
    showConfirm('선택 항목을 승인하시겠습니까?', function() {
        ajaxRequest(ctx + '/admin/class/approve', {classIds: ids.join(',')}, 'POST', function(res) { if (res.success) location.reload(); });
    });
}
function rejectSelected() {
    var ids = []; $('.chk-item:checked').each(function() { ids.push($(this).val()); });
    if (!ids.length) { showAlert('보류할 항목을 선택해주세요.'); return; }
    showConfirm('선택 항목을 보류하시겠습니까?', function() {
        ajaxRequest(ctx + '/admin/class/reject', {classIds: ids.join(',')}, 'POST', function(res) { if (res.success) location.reload(); });
    });
}
function deleteSelected() {
    var ids = []; $('.chk-item:checked').each(function() { ids.push($(this).val()); });
    if (!ids.length) { showAlert('삭제할 항목을 선택해주세요.'); return; }
    showConfirm('선택 항목을 삭제하시겠습니까?', function() {
        ajaxRequest(ctx + '/admin/class/delete', {classIds: ids.join(',')}, 'POST', function(res) { if (res.success) location.reload(); });
    });
}

$('.chk-all').on('change', function() {
    $('.chk-item').prop('checked', $(this).prop('checked'));
});
</script>