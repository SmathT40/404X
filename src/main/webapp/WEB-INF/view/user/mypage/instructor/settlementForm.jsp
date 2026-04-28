<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content">

    <h2 class="section-title">정산내역</h2>

    <form id="settleForm"
          action="${pageContext.request.contextPath}/mypage/instructor/settlement/register}"
          method="post">

        <c:if test="${not empty st}">
            <input type="hidden" name="settle_id" value="${st.settle_id}">
        </c:if>

        <div style="border-bottom:1px solid #eee;padding-bottom:8px;margin-bottom:16px;">
            <span style="font-weight:600;">정산내역 ${empty st ? '등록' : '수정'}</span>
        </div>

        <div class="form-row" style="margin-bottom: 20px;">
            <div class="form-label" style="font-weight: bold; margin-bottom: 8px; display: block;">정산 금액 (원)</div>
            <input type="number" name="pay_amount" class="form-control" placeholder="숫자만 입력해 주세요." value="${st.pay_amount}" required>
        </div>

        <div class="form-row" style="margin-bottom: 20px;">
            <div class="form-label" style="font-weight: bold; margin-bottom: 8px; display: block;">정산 상세내용</div>
            <textarea name="settle_content" class="form-control" style="width:100%; height:250px; resize:none; padding:12px; font-size:14px; border:1px solid #ccc; border-radius:4px;" placeholder="예: 2026년 4월분 정산 완료." required>${st.settle_content}</textarea>
        </div>

        <div style="text-align:center;display:flex;justify-content:center;gap:16px; margin-top:30px;">
            <a href="${pageContext.request.contextPath}/mypage/instructor/settlement" class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
            <button type="submit" class="btn btn-black btn-lg" style="min-width:120px;">${empty st ? '등록' : '수정'}</button>
        </div>

    </form>
</div>
</main>