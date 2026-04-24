<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강좌 등록 및 수정 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="admin-content">
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/host/class/status" class="tab-item inactive">클래스 현황</a>
        <a href="${pageContext.request.contextPath}/host/class/list"   class="tab-item active">전체 클래스</a>
    </div>

    <div class="admin-page">
        <form id="lectureForm"
              action="${pageContext.request.contextPath}/host/class/${empty lectureInfo ? 'insertLecture' : 'updateLecture'}"
              method="post" enctype="multipart/form-data">

            <c:if test="${not empty lectureInfo}">
                <input type="hidden" name="lectureId" value="${classVO.lectureId}">
            </c:if>

            <div style="font-weight:600;font-size:16px;margin-bottom:16px;padding-bottom:10px;border-bottom:1px solid #eee;">
                강의 ${empty lectureInfo ? '등록' : '수정'}
            </div>

            <div class="form-row">
                <div class="form-label">공개 여부</div>
                <div class="radio-group">
                    <label class="radio-label"><input type="radio" name="openYn" value="Y" ${classVO.openYn != 'N' ? 'checked' : ''}> 공개</label>
                    <label class="radio-label"><input type="radio" name="openYn" value="N" ${classVO.openYn == 'N' ? 'checked' : ''}> 비공개</label>
                </div>
            </div>

            <div class="form-row">
                <div class="form-label">소속 클래스</div>
                <select name="classId" class="form-control">
                    <option value="">클래스를 선택해주세요.</option>
                    <c:forEach var="cls" items="${myClassList}">
                        <option value="${cls.classId}" ${cls.classId == classVO.classId ? 'selected' : ''}>${cls.clsTitle}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-row">
                <div class="form-label">제목</div>
                <input type="text" name="title" class="form-control" placeholder="제목을 입력해 주세요." value="${classVO.clsTitle}">
            </div>

            <div class="form-row">
                <div class="form-label">첨부파일</div>
                <div class="file-upload-row" style="flex:1;">
                    <input type="text" id="lecFileName" class="form-control" placeholder="파일을 첨부해주세요." readonly
                           value="${classVO.attachFileName}">
                    <button type="button" class="btn btn-black btn-sm" onclick="$('#lecFile').click()">파일첨부</button>
                    <input type="file" id="lecFile" name="videoFile" style="display:none;" accept="video/*"
                           onchange="$('#lecFileName').val(this.files[0].name)">
                </div>
            </div>

            <%-- 에디터 영역 (강의 설명) --%>
            <div style="width:100%;height:300px;border:1px solid #eee;border-radius:8px;background:#f5f5f5;margin:12px 0;"></div>
            <textarea name="content" id="content" style="display:none;">${classVO.content}</textarea>

            <div style="display:flex;justify-content:center;gap:16px;margin-top:16px;">
                <a href="${pageContext.request.contextPath}/host/class/list" class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
                <button type="submit" class="btn btn-black btn-lg" style="min-width:120px;">등록</button>
            </div>

        </form>
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
