<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- ==============================
     공통 푸터 + 공통 JS 로드
     ============================== --%>

</div><%-- .wrap 닫기 --%>

<footer id="footer">
    <div class="footer-inner">
        <div class="footer-info">
            &copy; 2026 404 X CLUB. All rights reserved. &nbsp;|&nbsp;
            <a href="mailto:404xclubadmin@xclub.com">404xclubadmin@xclub.com</a>
        </div>
        <div>Tel: +82 2 111 2223 &nbsp;|&nbsp; Fax: +82 2 111 2222</div>
    </div>
</footer>

<%-- 맨 위로 버튼 --%>
<button id="scroll-top" onclick="window.scrollTo({top:0, behavior:'smooth'})">&#8593;</button>

<%-- 공통 모달 오버레이 (JS로 제어) --%>
<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">알림</div>
        <div class="modal-body" id="modalBody"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn" onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<%-- jQuery --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<%-- 공통 JS --%>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>

<%-- 추가 JS (각 페이지에서 param으로 전달) --%>
<%-- jsp:include 시 param.js 사용 가능 --%>

