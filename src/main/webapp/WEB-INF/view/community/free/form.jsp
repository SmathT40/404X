<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>게시글 작성 - 404 X CLUB</title>

<main class="content-area">
<div class="user-content" style="max-width:900px;">

    <h2 class="section-title">자유게시판</h2>

    <form id="freeForm"
          action="${pageContext.request.contextPath}/community/board/${board.board_no == 0 ? 'insert' : 'update'}"
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="boardid" value="1">
        <c:if test="${board.board_no != 0}">
            <input type="hidden" name="board_no" value="${board.board_no}">
        </c:if>

        <div style="border-bottom:1px solid #eee;padding-bottom:8px;
                    margin-bottom:16px;font-weight:600;">게시글쓰기</div>

        <div class="form-row">
            <div class="form-label">공개 여부</div>
            <div class="radio-group">
                <label class="radio-label">
                    <input type="radio" name="board_private" value="0"
                           ${board.board_private != 1 ? 'checked' : ''}> 공개
                </label>
                <label class="radio-label">
                    <input type="radio" name="board_private" value="1"
                           ${board.board_private == 1 ? 'checked' : ''}> 비공개
                </label>
            </div>
        </div>

        <div class="form-row">
            <div class="form-label">제목</div>
            <input type="text" name="board_title" class="form-control"
                   placeholder="제목을 입력해 주세요." value="${board.board_title}">
        </div>

        <div class="form-row">
            <div class="form-label">첨부파일</div>
            <div class="file-upload-row" style="flex:1;display:flex;gap:10px;">
                <input type="text" id="freeFileName" class="form-control"
                       placeholder="파일을 첨부해주세요." readonly value="${board.fileurl}">
                <button type="button" class="btn btn-black btn-sm"
                        onclick="$('#freeFile').click()">파일첨부</button>
                <input type="file" id="freeFile" name="board_file_path" style="display:none;"
                       onchange="$('#freeFileName').val(this.files[0].name)">
            </div>
        </div>

        <div class="form-row" style="margin-top:12px;width:100%;">
            <textarea name="board_content" id="summernote"
                      class="form-control" style="width:100%;">${board.board_content}</textarea>
        </div>

        <div style="display:flex;justify-content:center;gap:16px;margin-top:16px;">
            <a href="${pageContext.request.contextPath}/community/board/list?boardid=1"
               class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
            <button type="submit" class="btn btn-black btn-lg" style="min-width:120px;">등록</button>
        </div>

    </form>
</div>
</main>

<script>
function sendFile(file) {
    var data = new FormData();
    data.append("file", file);
    $.ajax({
        url: '${pageContext.request.contextPath}/community/board/uploadImage',
        type: 'POST',
        data: data,
        contentType: false,
        processData: false,
        success: function(res) {
            $('#summernote').summernote('insertImage', res.url);
        },
        error: function() {
            showAlert('이미지 업로드에 실패했습니다.');
        }
    });
}

$(function(){
    $("#summernote").summernote({
        height: 300,
        width: "100%",
        callbacks: {
            onImageUpload: function(images) {
                for(let i = 0; i < images.length; i++) {
                    sendFile(images[i]);
                }
            }
        }
    });

    $("#freeForm").on("submit", function(e){
        e.preventDefault();
        var form = this;

        var title = $('input[name=board_title]').val().trim();
        if(!title){
            showAlert('제목을 입력해주세요.');
            return;
        }

        var content = $("#summernote").summernote("code");
        if(!content || content == '<p><br></p>'){
            showAlert('내용을 입력해주세요.');
            return;
        }

        var isUpdate = $('input[name=board_no]').length > 0;
        var msg = isUpdate ? '수정하시겠습니까?' : '등록하시겠습니까?';

        showConfirm(msg, function(){
            $("#summernote").val(content);
            form.submit();
        });
    });
});
</script>