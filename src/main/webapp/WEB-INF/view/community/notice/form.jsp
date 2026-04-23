<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>공지사항 작성 - 404 X CLUB</title>

<main class="content-area">
<div class="user-content" style="max-width:900px;">

    <h2 class="section-title">공지사항</h2>

    <form id="noticeForm"
          action="${pageContext.request.contextPath}/community/board/${board.board_no == 0 ? 'insert' : 'update'}"
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="boardid" value="0">
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
                <input type="text" id="noticeFileName" class="form-control"
                       placeholder="파일을 첨부해주세요." readonly value="${board.fileurl}">
                <button type="button" class="btn btn-black btn-sm"
                        onclick="$('#noticeFile').click()">파일첨부</button>
                <input type="file" id="noticeFile" name="board_file_path" style="display:none;"
                       onchange="$('#noticeFileName').val(this.files[0].name)">
            </div>
        </div>

        <div class="form-row" style="margin-top:12px;width:100%;">
            <textarea name="board_content" id="summernote"
                      class="form-control" style="width:100%;">${board.board_content}</textarea>
        </div>

        <div style="display:flex;justify-content:center;gap:16px;margin-top:16px;">
            <a href="${pageContext.request.contextPath}/community/board/list?boardid=0"
               class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
            <button type="submit" class="btn btn-black btn-lg" style="min-width:120px;">등록</button>
        </div>

    </form>
</div>
</main>

<script>
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

    $("#noticeForm").on("submit", function(e){
        e.preventDefault();
        var content = $("#summernote").summernote("code");
        $("#summernote").val(content);
        this.submit();
    });
});
</script>
