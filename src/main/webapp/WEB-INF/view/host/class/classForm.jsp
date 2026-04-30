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
<div class="container mt-5">

    <h2 class="mb-4">
	    <c:choose>
	         	<c:when test="${not empty classDto}"> 강의 수정</c:when>
            	<c:otherwise>새 강의 등록</c:otherwise>
		</c:choose>
	</h2>
	<%--0428 --%>
   <form id="classForm" action="${pageContext.request.contextPath}/host/class/${empty classDto ? 'insert' : 'update'}" 
  method="post" enctype="multipart/form-data">
 <c:if test="${not empty classDto}">
    <input type="hidden" name="class_id" value="${classDto.class_id}">
</c:if>       
<div class="category-section mb-4">
    <label class="form-label-sm">강의 카테고리</label>
    <div class="form-row">
        <div class="col-auto">
            <select id="mainCategory" name="parent_code" class="form-control custom-select-sm" onchange="loadSubCategories(this.value)" required>
                <option value="">대분류</option>
                <c:forEach var="main" items="${categoryList}">
                    <option value="${main.category_code}" 
            		${main.category_code == parentCode ? 'selected' : ''}>${main.category_name}</option>
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
    <input type="text" name="cls_title" value="${classDto.cls_title}" class="form-control form-control-sm weight-700" placeholder="제목을 입력하세요" required>
</div>


<%-- 관리자가 아닐 경우를 대비해 기존 값을 hidden으로 유지 (수정 시 값이 날아가지 않도록) --%>
<c:if test="${sessionScope.loginUser.user_role != 2}">
    <input type="hidden" name="cls_featured" value="${empty classDto ? 0 : classDto.cls_featured}">
</c:if>

<div class="form-row mb-3">
    <div class="col-4">
        <label class="form-label-sm">판매가(원)</label>
        <input type="number" name="cls_price" value="${classDto.cls_price}" class="form-control form-control-sm text-right" required>
    </div>
    <div class="col-4">
        <label class="form-label-sm">수강기간(일)</label>
        <input type="number" name="cls_exp" value="${classDto.cls_exp}" class="form-control form-control-sm" required>
    </div>
</div>

        <div class="form-group">
            <label>강의 썸네일</label>
            <div class="custom-file">
                <input type="file" name="thumbnail_file" class="custom-file-input" id="clsThumbnail"
                 onchange="$('.custom-file-label').text(this.files[0].name)">
                <label class="custom-file-label" for="clsThumbnail">이미지 파일을 선택하세요</label>
            </div>
        </div>

        <div class="form-group">
            <label>강의 설명</label>
            <textarea name="cls_content" id="cls_content" class="form-control" rows="5" placeholder="강의에 대해 설명해주세요" required>${classDto.cls_content} </textarea>
        </div>
		    <%-- 관리자 전용 노출 설정 --%>
		    <c:if test="${sessionScope.loginUser.user_role == 2}">
		        <div class="custom-control custom-checkbox mr-3">
		            <input type="checkbox" name="cls_featured" class="custom-control-input" id="isFeatured" 
		                   value="1" ${classDto.cls_featured == 1 ? 'checked' : ''}>
		            <label class="custom-control-label font-weight-bold" for="isFeatured" style="cursor:pointer; font-size: 14px;">
		                상단 노출
		            </label>
		        </div>
		    </c:if>
        <div class="text-right pb-5">
            <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
            
            <button type="button" class="btn btn-primary" onclick="submitForm()">
            <c:choose>
            	<c:when test="${not empty classDto}">수정</c:when>
            	<c:otherwise>등록 신청</c:otherwise>
            </c:choose>
            </button>
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

//=========================================================================
//--- 썸머노트 이미지 업로드 추가 0428---
//=========================================================================
function sendFile(file) {
 var data = new FormData();
 data.append("file", file);
 $.ajax({
     url: '${pageContext.request.contextPath}/host/class/uploadImage',
     type: 'POST',
     data: data,
     contentType: false,
     processData: false,
     success: function(res) {
         $('#cls_content').summernote('insertImage', res.url);
     },
     error: function() {
         showAlert('이미지 업로드에 실패했습니다.');
     }
 });
}

$(function(){
 $('#cls_content').summernote({
     height: 300,
     width: '100%',
     callbacks: {
         onImageUpload: function(images) {
             for(var i = 0; i < images.length; i++) {
                 sendFile(images[i]);
             }
         }
     }
 });
});
function submitForm(){
    var content = $('#cls_content').summernote('code');
    if(!content || content == '<p><br></p>'){
        showAlert('강의 설명을 입력해주세요.');
        return;
    }
    $('#classForm').submit();
}
</script>
