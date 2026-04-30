<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강좌 등록 및 수정 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* =============================================
   강좌 등록/수정 폼 전용 스타일
   ============================================= */
.lec-form-wrap {
    max-width: 780px;
    margin: 36px auto;
    padding: 0 20px;
}

.lec-form-card {
    background: #fff;
    border: 1px solid #eee;
    border-radius: 12px;
    padding: 36px 40px 32px;
}

.lec-form-card h2 {
    font-size: 20px;
    font-weight: 800;
    color: #111;
    margin-bottom: 28px;
    padding-bottom: 20px;
    border-bottom: 1px solid #eee;
}

.lf-group {
    margin-bottom: 22px;
}

.lf-label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    color: #444;
    margin-bottom: 7px;
}

.lf-input,
.lf-select,
.lf-textarea {
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

.lf-input:focus,
.lf-select:focus,
.lf-textarea:focus {
    border-color: #111;
    outline: none;
}

.lf-input::placeholder,
.lf-textarea::placeholder {
    color: #bbb;
}

.lf-textarea {
    resize: vertical;
    min-height: 160px;
    line-height: 1.6;
}

.lf-row {
    display: grid;
    gap: 16px;
    margin-bottom: 22px;
}

.lf-row-3 { grid-template-columns: 1fr auto auto; }

.lf-select-wrap {
    position: relative;
}

.lf-select-wrap::after {
    content: '▾';
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 13px;
    color: #888;
    pointer-events: none;
}

.lf-select-wrap .lf-select {
    padding-right: 32px;
}

.lf-input-sm {
    width: 100px;
}

.lf-actions {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    margin-top: 28px;
    padding-top: 24px;
    border-top: 1px solid #eee;
}

.lf-btn-cancel {
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

.lf-btn-cancel:hover {
    background: #f5f5f5;
}

.lf-btn-submit {
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

.lf-btn-submit:hover {
    background: #c0303c;
}

.lf-editor-wrap .note-editor {
    border: 1.5px solid #e0e0e0 !important;
    border-radius: 8px !important;
    overflow: hidden;
}

.lf-editor-wrap .note-toolbar {
    background: #f7f7f7 !important;
    border-bottom: 1px solid #eee !important;
}
</style>

<div class="lec-form-wrap">
    <div class="lec-form-card">

        <h2>${empty lecDto ? '새 강좌 등록' : '강좌 정보 수정'}</h2>

        <form action="${pageContext.request.contextPath}/host/class/${empty lecDto ? 'lecinsert' : 'lecupdate'}"
              method="post" id="lectureForm">

            <c:if test="${not empty lecDto}">
                <input type="hidden" name="lec_id" value="${lecDto.lec_id}">
            </c:if>

            <%-- 강의 선택 / 차시 / 재생시간 --%>
            <div class="lf-row lf-row-3">
                <div class="lf-group" style="margin-bottom:0">
                    <label class="lf-label">강의</label>
                    <div class="lf-select-wrap">
                        <select name="class_id" class="lf-select" required>
                            <option value="">강의를 선택해주세요</option>
                            <c:forEach var="cls" items="${myClassList}">
                                <option value="${cls.class_id}"
                                        ${cls.class_id == lecDto.class_id ? 'selected' : ''}>
                                    ${cls.cls_title}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="lf-group" style="margin-bottom:0">
                    <label class="lf-label">강좌 차시</label>
                    <input type="number" name="lec_no" class="lf-input lf-input-sm text-center"
                           value="${lecDto.lec_no}" placeholder="1" required>
                </div>
                <div class="lf-group" style="margin-bottom:0">
                    <label class="lf-label">재생 시간</label>
                    <input type="text" name="lec_time_str" class="lf-input lf-input-sm text-center"
                           value="${lecDto.lec_time_str}" placeholder="15:00" required>
                </div>
            </div>

            <%-- 강좌 제목 --%>
            <div class="lf-group">
                <label class="lf-label">강좌 제목</label>
                <input type="text" name="lec_title" class="lf-input"
                       value="${lecDto.lec_title}" placeholder="제목을 입력하세요" required>
            </div>

            <%-- 강좌 URL --%>
            <div class="lf-group">
                <label class="lf-label">강좌 주소</label>
                <input type="text" name="lec_url" class="lf-input"
                       value="${lecDto.lec_url}" placeholder="강좌 URL" required>
            </div>

            <%-- 강좌 설명 (summernote) --%>
            <div class="lf-group">
                <label class="lf-label">강좌 설명</label>
                <div class="lf-editor-wrap">
                    <textarea name="lec_content" id="lec_content" class="lf-textarea"
                              placeholder="강좌에 대해 설명해주세요" required>${lecDto.lec_content}</textarea>
                </div>
            </div>

            <%-- 하단 버튼 --%>
            <div class="lf-actions">
                <button type="button" class="lf-btn-cancel" onclick="history.back()">취소</button>
                <button type="submit" class="lf-btn-submit">
                    ${empty lecDto ? '등록' : '수정 완료'}
                </button>
            </div>

        </form>
    </div>
</div>

<script>
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
            $('#lec_content').summernote('insertImage', res.url);
        },
        error: function() {
            showAlert('이미지 업로드에 실패했습니다.');
        }
    });
}

$(function() {
    $('#lec_content').summernote({
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
</script>