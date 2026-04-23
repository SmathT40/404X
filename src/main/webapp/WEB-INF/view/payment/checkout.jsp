<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<title>결제하기 - 404 X CLUB</title>

<body>
<main class="content-area">
<div class="user-content" style="max-width:700px;">

    <h2 class="section-title">결제정보</h2>

    <%-- 결제 강의 목록 --%>
    <table class="data-table" style="margin-bottom:24px;">
        <thead>
            <tr><th>강의명</th><th>강사명</th><th>가격</th><th>등록일</th><th>관리</th></tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${checkoutList}">
                <tr>
                    <td>${item.className}</td>
                    <td>${item.userName}</td>
                    <td><fmt:formatNumber value="${item.clsPrice}" pattern="#,###"/>원</td>
                    <td>${item.addDate}</td>
                    <td>
                        <button class="btn btn-black btn-sm" onclick="removeItem(${item.cartId})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <%-- 주문자 정보 --%>
    <div class="card" style="margin-bottom:20px;">
        <div style="font-weight:600;margin-bottom:16px;padding-bottom:8px;border-bottom:1px solid #eee;">주문자 정보</div>
        <table style="width:100%;font-size:13px;border-collapse:collapse;">
            <tr>
                <td style="padding:8px 0;color:#888;width:80px;">이름</td>
                <td style="padding:8px 0;background:#f9f9f9;padding-left:12px;border-radius:4px;">${sessionScope.loginUser.userName}</td>
            </tr>
            <tr>
                <td style="padding:8px 0;color:#888;">연락처</td>
                <td style="padding:8px 0;background:#f9f9f9;padding-left:12px;border-radius:4px;">${sessionScope.loginUser.userPhone}</td>
            </tr>
            <tr>
                <td style="padding:8px 0;color:#888;">이메일</td>
                <td style="padding:8px 0;background:#f9f9f9;padding-left:12px;border-radius:4px;">${sessionScope.loginUser.userEmail}</td>
            </tr>
        </table>
    </div>

    <%-- 결제수단 --%>
    <div class="card" style="margin-bottom:24px;">
        <div style="font-weight:600;margin-bottom:16px;padding-bottom:8px;border-bottom:1px solid #eee;">결제수단</div>
        <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px;">
            <label style="cursor:pointer;">
                <input type="radio" name="payMethod" value="NAVER" style="display:none;" id="payNaver">
                <div class="pay-btn" data-for="payNaver" style="background:#03C75A;color:#fff;border-radius:8px;padding:14px;text-align:center;font-weight:700;font-size:14px;">
                    <span style="margin-right:4px;font-weight:900;">N</span>pay
                </div>
            </label>
            <label style="cursor:pointer;">
                <input type="radio" name="payMethod" value="KAKAO" style="display:none;" id="payKakao">
                <div class="pay-btn" data-for="payKakao" style="background:#FEE500;color:#3C1E1E;border-radius:8px;padding:14px;text-align:center;font-weight:700;font-size:14px;">
                    &#128388;pay
                </div>
            </label>
            <label style="cursor:pointer;">
                <input type="radio" name="payMethod" value="BANK" style="display:none;" id="payBank">
                <div class="pay-btn" data-for="payBank" style="background:#f5f5f5;color:#333;border-radius:8px;padding:14px;text-align:center;font-size:14px;border:1px solid #eee;">
                    무통장입금
                </div>
            </label>
        </div>
    </div>

    <%-- 최종 결제금액 --%>
    <div class="card" style="margin-bottom:28px;">
        <div style="font-weight:600;margin-bottom:16px;padding-bottom:8px;border-bottom:1px solid #eee;">최종 결제금액</div>
        <c:set var="total" value="0"/>
        <c:forEach var="item" items="${checkoutList}">
            <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:10px;">
                <span>${item.className}</span>
                <span>${item.userName}</span>
                <span><fmt:formatNumber value="${item.clsPrice}" pattern="#,###"/>원</span>
            </div>
            <c:set var="total" value="${total + item.clsPrice}"/>
        </c:forEach>
        <div style="text-align:right;font-size:16px;font-weight:700;margin-top:16px;padding-top:12px;border-top:1px solid #eee;">
            총 금액 <span style="color:#e63946;"><fmt:formatNumber value="${total}" pattern="#,###"/>원</span>
        </div>
    </div>

    <%-- 버튼 --%>
    <div style="display:flex;justify-content:center;gap:16px;">
        <a href="${pageContext.request.contextPath}/payment/cart" class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
        <button class="btn btn-black btn-lg" style="min-width:120px;" onclick="doPayment()">구매하기</button>
    </div>

</div>
</main>

<script>
/* 결제수단 선택 스타일 */
$('input[name=payMethod]').on('change', function(){
    $('.pay-btn').css('outline','none');
    $('[data-for=' + $(this).attr('id') + ']').css('outline','2px solid #222');
});

/* 결제 실행 */
function doPayment(){
    var method = $('input[name=payMethod]:checked').val();
    if(!method){ showAlert('결제수단을 선택해주세요.'); return; }
    var cartIds = '${cartIds}';
    ajaxRequest('${pageContext.request.contextPath}/payment/pay',
        {cartIds: cartIds, payMethod: method}, 'POST',
        function(res){
            if(res.success){
                showAlert('결제가 완료되었습니다.', function(){
                    location.href = '${pageContext.request.contextPath}/mypage/classroom';
                });
            } else {
                showAlert(res.msg || '결제에 실패했습니다.');
            }
        }
    );
}
</script>
</body>
