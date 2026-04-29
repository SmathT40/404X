<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강좌 등록 및 수정 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<style>
.custom-select-sm, 
.form-control-sm, 
.form-control,   
.custom-file-label {
    height: 45px !important; 
    font-size: 14px;
    font-weight: 600;
    border: 2px solid #eee !important; 
    border-radius: 6px;
    display: flex;
    align-items: center;
}
.form-control:focus, 
.custom-select-sm:focus, 
.form-control-sm:focus {
    border-color: #1a1a1a !important;
    box-shadow: none;
    outline: none;
}
textarea.form-control {
    height: auto !important;
    min-height: 150px;
    padding: 15px;
}
.custom-file-label::after {
    height: 41px;
    display: flex;
    align-items: center;
    background-color: #1a1a1a;
    color: #fff;
    font-weight: 700;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<div class="container mt-5">
    <h2 class="mb-4">${empty lecDto ? '새 강좌 등록' : '강좌 정보 수정'}</h2>
	<form action="${pageContext.request.contextPath}/host/class/${empty lecDto ? 'lecinsert' : 'lecupdate'}" 
          method="post" id="lectureForm">
    <c:if test="${not empty lecDto}">
        <input type="hidden" name="lec_id" value="${lecDto.lec_id}">
    </c:if>
<div class="category-section mb-4">
    <div class="form-row">
        <div class="col-6">
    	<label class="form-label-sm">강의</label>
            <select name="class_id" class="form-control custom-select-sm" onchange="loadSubCategories(this.value)" required>
               <option value="">강의를 선택해주세요</option>
				<c:forEach var="cls" items="${myClassList}">
	                <%-- 기존 데이터와 일치하면 selected 처리 --%>
	                <option value="${cls.class_id}" ${cls.class_id == lecDto.class_id ? 'selected' : ''}>
	                    ${cls.cls_title}
	                </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-2">
        <label class="form-label-sm">강좌 차시</label>
			<div class="col-auto">
                <input type="number" name="lec_no" class="form-control form-control-sm text-center" value="${lecDto.lec_no}" placeholder="1" required>
            </div>
        </div>
        <div class="col-2">
        <label class="form-label-sm">재생 시간</label>
			<div class="col-auto">
                <input type="text" name="lec_time_str" class="form-control form-control-sm text-center" value="${lecDto.lec_time_str}"placeholder="15:00" required>
            </div>
        </div>
    </div>
</div>

<div class="form-group mb-3">
    <label class="form-label-sm">강좌 제목</label>
    <input type="text" name="lec_title" class="form-control form-control-sm weight-700" value="${lecDto.lec_title}"placeholder="제목을 입력하세요" required>
</div>
<div class="form-group mb-3">
    <label class="form-label-sm">강좌 주소</label>
    <input type="text" name="lec_url" class="form-control form-control-sm weight-700" value="${lecDto.lec_url}"placeholder="강좌 URL" required>
</div>

        <div class="form-group">
            <label>강좌 설명</label>
            <textarea name="lec_content" class="form-control" rows="5" placeholder="강좌에 대해 설명해주세요" required>${lecDto.lec_content}</textarea>
        </div>

        <div class="text-right pb-5">
			<button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
            <%-- 버튼 텍스트 분기 --%>
            <button type="submit" class="btn btn-primary">
                ${empty lecDto ? '등록' : '수정 완료'}
            </button>
        </div>
    </form>
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

