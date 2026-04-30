<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 등록 및 수정 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<style>
/* =============================================
   강의 등록/수정 폼 전용 스타일
   ============================================= */
.class-form-wrap {
    max-width: 780px;
    margin: 36px auto;
    padding: 0 20px;
}

.class-form-card {
    background: #fff;
    border: 1px solid #eee;
    border-radius: 12px;
    padding: 36px 40px 32px;
}

.class-form-card h2 {
    font-size: 20px;
    font-weight: 800;
    color: #111;
    margin-bottom: 28px;
    padding-bottom: 20px;
    border-bottom: 1px solid #eee;
}

.cf-group {
    margin-bottom: 22px;
}

.cf-label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #444;
    margin-bottom: 7px;
}

.cf-input,
.cf-select,
.cf-textarea {
    width: 100%;
    padding: 10px 14px;
    border: 1.5px solid #e0e0e0;
    border-radius: 8px;
    font-size: 14px;
    font-family: inherit;
    color: #222;
    background: #fff;
    transition: border-color 0.2s;
    appearance: none;
    -webkit-appearance: none;
}

.cf-input:focus,
.cf-select:focus,
.cf-textarea:focus {
    border-color: #111;
    outline: none;
}

.cf-input::placeholder,
.cf-textarea::placeholder {
    color: #bbb;
}

.cf-textarea {
    resize: vertical;
    min-height: 160px;
    line-height: 1.6;
}

.cf-row {
    display: grid;
    gap: 16px;
    margin-bottom: 22px;
}

.cf-row-2   { grid-template-columns: 1fr 1fr; }
.cf-row-cat { grid-template-columns: 180px 180px; }

.cf-select-wrap {
    position: relative;
}

.cf-select-wrap::after {
    content: '▾';
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 13px;
    color: #888;
    pointer-events: none;
}

.cf-select-wrap .cf-select {
    padding-right: 32px;
}

.cf-file-row {
    display: flex;
    align-items: center;
    gap: 10px;
}

.cf-file-text {
    flex: 1;
    padding: 10px 14px;
    border: 1.5px solid #e0e0e0;
    border-radius: 8px;
    font-size: 13px;
    color: #bbb;
    background: #fafafa;
    cursor: default;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.cf-file-text.selected {
    color: #222;
    background: #fff;
}

.cf-file-btn {
    padding: 10px 18px;
    background: #111;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    white-space: nowrap;
    font-family: inherit;
    flex-shrink: 0;
}

.cf-file-btn:hover {
    background: #333;
}

.cf-editor-wrap .note-editor {
    border: 1.5px solid #e0e0e0 !important;
    border-radius: 8px !important;
    overflow: hidden;
}

.cf-editor-wrap .note-toolbar {
    background: #f7f7f7 !important;
    border-bottom: 1px solid #eee !important;
}

.cf-check-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 22px;
}

.cf-check-row input[type="checkbox"] {
    width: 16px;
    height: 16px;
    accent-color: #e63946;
    cursor: pointer;
}

.cf-check-row label {
    font-size: 13px;
    font-weight: 600;
    color: #444;
    cursor: pointer;
}

.cf-actions {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    margin-top: 28px;
    padding-top: 24px;
    border-top: 1px solid #eee;
}

.cf-btn-cancel {
    padding: 10px 24px;
    border: 1.5px solid #ddd;
    border-radius: 30px;
    background: #fff;
    color: #666;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    font-family: inherit;
    transition: all 0.2s;
}

.cf-btn-cancel:hover {
    background: #f5f5f5;
}

.cf-btn-submit {
    padding: 10px 28px;
    border: none;
    border-radius: 30px;
    background: #e63946;
    color: #fff;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    font-family: inherit;
    transition: all 0.2s;
}

.cf-btn-submit:hover {
    background: #c0303c;
}

#clsThumbnailReal {
    display: none;
}
</style>

<div class="class-form-wrap">
    <div class="class-form-card">

        <h2>
            <c:choose>
                <c:when test="${not empty classDto}">강의 수정</c:when>
                <c:otherwise>새 강의 등록</c:otherwise>
            </c:choose>
        </h2>

        <form id="classForm"
              action="${pageContext.request.contextPath}/host/class/${empty classDto ? 'insert' : 'update'}"
              method="post" enctype="multipart/form-data">

            <c:if test="${not empty classDto}">
                <input type="hidden" name="class_id" value="${classDto.class_id}">
            </c:if>

            <div class="cf-group">
                <label class="cf-label">강의 카테고리</label>
                <div class="cf-row cf-row-cat">
                    <div class="cf-select-wrap">
                        <select id="mainCategory" name="parent_code" class="cf-select"
                                onchange="loadSubCategories(this.value)" required>
                            <option value="">대분류</option>
                            <c:forEach var="main" items="${categoryList}">
                                <option value="${main.category_code}"
                                        ${main.category_code == parentCode ? 'selected' : ''}>
                                    ${main.category_name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="cf-select-wrap">
                        <select id="subCategory" name="category_code" class="cf-select" required>
                            <option value="">소분류</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="cf-group">
                <label class="cf-label">강의 제목</label>
                <input type="text" name="cls_title" value="${classDto.cls_title}"
                       class="cf-input" placeholder="제목을 입력하세요" required>
            </div>

            <div class="cf-row cf-row-2">
                <div class="cf-group" style="margin-bottom:0">
                    <label class="cf-label">판매가 (원)</label>
                    <input type="number" name="cls_price" value="${classDto.cls_price}"
                           class="cf-input" placeholder="0" required>
                </div>
                <div class="cf-group" style="margin-bottom:0">
                    <label class="cf-label">수강기간 (일)</label>
                    <input type="number" name="cls_exp" value="${classDto.cls_exp}"
                           class="cf-input" placeholder="0" required>
                </div>
            </div>

            <div class="cf-group" style="margin-top:22px">
                <label class="cf-label">강의 썸네일</label>
                <div class="cf-file-row">
                    <div class="cf-file-text" id="fileNameDisplay">이미지 파일을 선택하세요</div>
                    <button type="button" class="cf-file-btn"
                            onclick="document.getElementById('clsThumbnailReal').click()">Browse</button>
                    <input type="file" id="clsThumbnailReal" name="thumbnail_file"
                           accept="image/*" onchange="updateFileName(this)">
                </div>
            </div>

            <div class="cf-group">
                <label class="cf-label">강의 설명</label>
                <div class="cf-editor-wrap">
                    <textarea name="cls_content" id="cls_content" class="cf-textarea"
                              placeholder="강의에 대해 설명해주세요" required>${classDto.cls_content}</textarea>
                </div>
            </div>

            <c:if test="${sessionScope.loginUser.user_role != 2}">
                <input type="hidden" name="cls_featured"
                       value="${empty classDto ? 0 : classDto.cls_featured}">
            </c:if>

            <c:if test="${sessionScope.loginUser.user_role == 2}">
                <div class="cf-check-row">
                    <input type="checkbox" name="cls_featured" id="isFeatured"
                           value="1" ${classDto.cls_featured == 1 ? 'checked' : ''}>
                    <label for="isFeatured">상단 노출</label>
                </div>
            </c:if>

            <div class="cf-actions">
                <button type="button" class="cf-btn-cancel" onclick="history.back()">취소</button>
                <button type="button" class="cf-btn-submit" onclick="submitForm()">
                    <c:choose>
                        <c:when test="${not empty classDto}">수정</c:when>
                        <c:otherwise>등록 신청</c:otherwise>
                    </c:choose>
                </button>
            </div>

        </form>
    </div>
</div>

<script>
function updateFileName(input) {
    var display = document.getElementById('fileNameDisplay');
    if (input.files && input.files[0]) {
        display.textContent = input.files[0].name;
        display.classList.add('selected');
    } else {
        display.textContent = '이미지 파일을 선택하세요';
        display.classList.remove('selected');
    }
}

function loadSubCategories(parentCode) {
    var $subSelect = $('#subCategory');
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
            $subSelect.empty().append('<option value="">소분류</option>');
            if (data && data.length > 0) {
                $.each(data, function(index, item) {
                    $subSelect.append(
                        '<option value="' + item.category_code + '">' + item.category_name + '</option>'
                    );
                });
            }
        },
        error: function(xhr) {
            console.error("에러 발생:", xhr.status);
            alert("데이터를 가져오지 못했습니다.");
        }
    });
}

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

$(function() {
    $('#cls_content').summernote({
        height: 300,
        width: '100%',
        callbacks: {
            onImageUpload: function(images) {
                for (var i = 0; i < images.length; i++) {
                    sendFile(images[i]);
                }
            }
        }
    });
});

function submitForm() {
	var mainCat = $('#mainCategory').val();
    if (!mainCat) {
    	showAlert('대분류 카테고리를 선택해주세요.');
        $('#mainCategory').focus();
        return;
    }
    var subCat = $('#subCategory').val();
    if (!subCat) {
    	showAlert('소분류 카테고리를 선택해주세요.');
        $('#subCategory').focus();
        return;
    }
    var content = $('#cls_content').summernote('code');
    if (!content || content === '<p><br></p>') {
        showAlert('강의 설명을 입력해주세요.');
        return;
    }
    $('#classForm').submit();
}
</script>