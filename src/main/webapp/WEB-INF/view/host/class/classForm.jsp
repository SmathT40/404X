<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 등록 및 수정 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
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
    <h2 class="mb-4">새 강의 등록</h2>
    <form action="${pageContext.request.contextPath}/host/class/insert" method="post" enctype="multipart/form-data">
        
<div class="category-section mb-4">
    <label class="form-label-sm">강의 카테고리</label>
    <div class="form-row">
        <div class="col-auto">
            <select id="mainCategory" name="parent_code" class="form-control custom-select-sm" onchange="loadSubCategories(this.value)" required>
                <option value="">대분류</option>
                <c:forEach var="main" items="${categoryList}">
                    <option value="${main.category_code}">${main.category_name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-auto">
            <select id="subCategory" name="category_code" class="form-control custom-select-sm" required>
                <option value="">소분류</option>
            </select>
        </div>
    </div>
</div>

<div class="form-group mb-3">
    <label class="form-label-sm">강의 제목</label>
    <input type="text" name="cls_title" class="form-control form-control-sm weight-700" placeholder="제목을 입력하세요" required>
</div>

<div class="form-row mb-3">
    <div class="col-4">
        <label class="form-label-sm">판매가(원)</label>
        <input type="number" name="cls_price" class="form-control form-control-sm text-right" value="0" required>
    </div>
    <div class="col-4">
        <label class="form-label-sm">수강기간(일)</label>
        <input type="number" name="cls_exp" class="form-control form-control-sm" value="90" required>
    </div>
</div>

        <div class="form-group">
            <label>강의 썸네일</label>
            <div class="custom-file">
                <input type="file" name="thumbnail_file" class="custom-file-input" id="clsThumbnail">
                <label class="custom-file-label" for="clsThumbnail">이미지 파일을 선택하세요</label>
            </div>
        </div>

        <div class="form-group">
            <label>강의 설명</label>
            <textarea name="cls_content" class="form-control" rows="5" placeholder="강의에 대해 설명해주세요" required></textarea>
        </div>

        <div class="text-right pb-5">
            <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
            <button type="submit" class="btn btn-primary">등록 신청</button>
        </div>
    </form>
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

<script>
function loadSubCategories(parentCode) {
    const $subSelect = $('#subCategory');

    if (!parentCode) {
        $subSelect.html('<option value="">소분류</option>');
        return;
    }

    $.ajax({
        url: '${pageContext.request.contextPath}/category/sub-list',
        type: 'GET',
        data: { parent_code: parentCode },
        dataType: 'json', 
        success: function(data) {
        	console.log(data);
            // 1. 기존 내용을 싹 비우고 기본 옵션 추가
            $subSelect.empty().append('<option value="">소분류</option>');

            // 2. 서버에서 온 데이터(배열)를 돌면서 옵션 추가
            if (data && data.length > 0) {
                $.each(data, function(index, item) {
                    // item.category_code와 item.category_name은 Dto 필드명과 대소문자까지 같아야 함
                    $subSelect.append('<option value="' + item.category_code + '">' + item.category_name + '</option>');
                });
            }
        },
        error: function(xhr) {
            console.error("에러 발생:", xhr.status);
            alert("데이터를 가져오지 못했습니다.");
        }
    });
}
</script>
