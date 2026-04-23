<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 등록 및 수정 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>


<div class="admin-content">
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/host/class/status" class="tab-item inactive">클래스 현황</a>
        <a href="${pageContext.request.contextPath}/host/class/list"   class="tab-item active">전체 클래스</a>
    </div>

    <div class="admin-page">
        <form id="classForm"
              action="${pageContext.request.contextPath}/host/class/${empty classInfo ? 'insert' : 'update'}"
              method="post" enctype="multipart/form-data">

            <c:if test="${not empty classInfo}">
                <input type="hidden" name="classId" value="${classInfo.classId}">
            </c:if>

            <div style="font-weight:600;font-size:16px;margin-bottom:16px;padding-bottom:10px;border-bottom:1px solid #eee;">
                ${empty classInfo ? '클래스 등록' : '클래스 수정'}
            </div>

            <div class="form-row">
                <div class="form-label">공개 여부</div>
                <div class="radio-group">
                    <label class="radio-label"><input type="radio" name="openYn" value="Y" ${classInfo.openYn != 'N' ? 'checked' : ''}> 공개</label>
                    <label class="radio-label"><input type="radio" name="openYn" value="N" ${classInfo.openYn == 'N' ? 'checked' : ''}> 비공개</label>
                </div>
            </div>

            <div class="form-row">
                <div class="form-label">제목</div>
                <input type="text" name="title" class="form-control" placeholder="제목을 입력해 주세요." value="${classInfo.title}">
            </div>

            <div class="form-row">
                <div class="form-label">첨부파일</div>
                <div class="file-upload-row" style="flex:1;">
                    <input type="text" id="classFileName" class="form-control" placeholder="파일을 첨부해주세요." readonly>
                    <button type="button" class="btn btn-black btn-sm" onclick="$('#classFile').click()">파일첨부</button>
                    <input type="file" id="classFile" name="attachFile" style="display:none;"
                           onchange="$('#classFileName').val(this.files[0].name)">
                </div>
            </div>

            <div style="width:100%;height:300px;border:1px solid #eee;border-radius:8px;background:#f5f5f5;margin:12px 0;"></div>
            <textarea name="content" id="content" style="display:none;">${classInfo.content}</textarea>

            <div style="display:flex;justify-content:center;gap:16px;margin-top:16px;">
                <a href="${pageContext.request.contextPath}/host/class/list" class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
                <button type="button" class="btn btn-black btn-lg" style="min-width:120px;" onclick="submitClassForm()">등록</button>
            </div>

        </form>
    </div>
</div>
</div>

<%-- 클래스 등록 완료 모달 --%>
<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">클래스등록</div>
        <div class="modal-body"  id="modalBody">클래스등록 승인이 요청되었습니다.</div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn"  onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
function submitClassForm(){
    if(!$('input[name=title]').val().trim()){ showAlert('제목을 입력해주세요.'); return; }
    $('#classForm').submit();
    openModal('클래스등록', '클래스등록 승인이 요청되었습니다.', function(){
        location.href = '${pageContext.request.contextPath}/host/class/list';
    });
}
</script>
