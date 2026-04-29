<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>메일 발송 - 404 X CLUB</title>

<div class="admin-page">
    <div class="admin-section">
        <div class="admin-section-header">
            <span class="admin-section-title">메일 발송</span>
        </div>

        <div class="form-group" style="margin-bottom:16px;">
            <div class="form-label">수신자</div>
            <input type="text" id="emails" class="form-control" value="${emails}" readonly>
        </div>

        <div class="form-group" style="margin-bottom:16px;">
            <div class="form-label">제목</div>
            <input type="text" id="subject" class="form-control" placeholder="메일 제목을 입력해주세요.">
        </div>

        <div class="form-group" style="margin-bottom:16px;">
            <div class="form-label">내용</div>
            <textarea id="mailContent"></textarea>
        </div>

        <div style="text-align:right;margin-top:16px;">
            <button class="btn btn-ghost btn-lg" onclick="history.back()">취소</button>
            <button class="btn btn-black btn-lg" onclick="sendMail()">발송</button>
        </div>
    </div>
</div>

<script>
$(function(){
    $('#mailContent').summernote({
        height: 400,
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
var ctx = '${pageContext.request.contextPath}';
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
            $('#mailContent').summernote('insertImage', res.url);
        }
    });
}

function sendMail(){
    var emails = $('#emails').val().trim();
    var subject = $('#subject').val().trim();
    var content = $('#mailContent').summernote('code');

    if(!subject){ showAlert('제목을 입력해주세요.'); return; }
    if(!content || content == '<p><br></p>'){ showAlert('내용을 입력해주세요.'); return; }

    showConfirm('메일을 발송하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/admin/mail/send',
            {emails: emails, subject: subject, content: content}, 'POST',
            function(res){
                if(res.success){
                    showAlert('메일이 발송되었습니다.');
                    setTimeout(function(){
                        location.href = ctx + '/admin/member/list';
                    }, 1000);
                } else {
                    showAlert('메일 발송에 실패했습니다.');
                }
            }
        );
    });
}
</script>