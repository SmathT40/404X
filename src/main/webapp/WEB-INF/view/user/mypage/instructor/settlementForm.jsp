<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <h2 class="section-title">정산내역</h2>

    <form id="settleForm"
          action="${pageContext.request.contextPath}/mypage/instructor/settlement/${empty settleInfo ? 'insert' : 'update'}"
          method="post" enctype="multipart/form-data">

        <c:if test="${not empty settleInfo}">
            <input type="hidden" name="settleId" value="${settleInfo.settleId}">
        </c:if>

        <div style="border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
            <span style="font-weight:600;">정산내역 등록</span>
        </div>

        <div class="form-row">
            <div class="form-label">공개 여부</div>
            <div class="radio-group">
                <label class="radio-label">
                    <input type="radio" name="openYn" value="Y" ${settleInfo.useYn != 'N' ? 'checked' : ''}> 공개
                </label>
                <label class="radio-label">
                    <input type="radio" name="openYn" value="N" ${settleInfo.useYn == 'N' ? 'checked' : ''}> 비공개
                </label>
            </div>
        </div>

        <div class="form-row">
            <div class="form-label">제목</div>
            <input type="text" name="title" class="form-control" placeholder="제목을 입력해 주세요." value="${settleInfo.clsTitle}">
        </div>

        <div class="form-row">
            <div class="form-label">첨부파일</div>
            <div class="file-upload-row" style="flex:1;">
                <input type="text" id="settleFileName" class="form-control" placeholder="파일을 첨부해주세요." readonly>
                <button type="button" class="btn btn-black btn-sm" onclick="$('#settleFile').click()">파일첨부</button>
                <input type="file" id="settleFile" name="attachFile" style="display:none;"
                       onchange="$('#settleFileName').val(this.files[0].name)">
            </div>
        </div>

        <%-- 에디터 영역 (실제로는 summernote 등 Rich Editor 연동) --%>
        <div style="width:100%;height:300px;border:1px solid #eee;border-radius:8px;background:#f5f5f5;margin:16px 0;"></div>
        <textarea name="content" id="content" style="display:none;">${settleInfo.clsContent}</textarea>

        <div style="text-align:center;display:flex;justify-content:center;gap:16px;">
            <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
            <button type="submit" class="btn btn-black btn-lg" style="min-width:120px;">등록</button>
        </div>

    </form>
</div>
</main>
