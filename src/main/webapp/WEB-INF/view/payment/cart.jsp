<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<title>장바구니 - 404 X CLUB</title>

<main class="content-area">
<div class="container" style="max-width:900px;">

    <h2 class="section-title">장바구니</h2>

    <div style="display:flex;justify-content:flex-end;margin-bottom:8px;">
        <button class="btn btn-ghost btn-sm" onclick="deleteSelected()">선택삭제</button>
    </div>

    <table class="data-table" id="cartTable">
        <thead>
            <tr>
                <th><input type="checkbox" class="chk-all"></th>
                <th>강의명</th><th>강사명</th><th>가격</th><th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty cartList}">
                    <c:forEach var="item" items="${cartList}" varStatus="st">
                        <tr>
                            <td><input type="checkbox" class="chk-item" value="${st.index}"></td>
                            <td>${item.cls_title}</td>
                            <td>${item.user_name}</td>
                            <td><fmt:formatNumber value="${item.cls_price}" pattern="#,###"/>원</td>
                            <td>
                                <button class="btn btn-black btn-sm" onclick="deleteItem(${st.index})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="5" style="text-align:center;color:#aaa;padding:40px;">장바구니가 비어있습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div style="text-align:right;margin-top:16px;font-size:15px;font-weight:600;">
        총 금액 <span style="color:#e63946;" id="totalPrice">0원</span>
    </div>

    <div style="text-align:center;display:flex;justify-content:center;gap:16px;margin-top:28px;">
        <a href="${pageContext.request.contextPath}/class/list" class="btn btn-ghost btn-lg" style="min-width:120px;">취소</a>
        <button class="btn btn-black btn-lg" style="min-width:120px;" onclick="gotoCheckout()">구매하기</button>
    </div>

</div>
</main>

<script>
function deleteSelected(){
    var ids = [];
    $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('삭제할 항목을 선택해주세요.'); return; }
    showConfirm('선택한 항목을 삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/payment/cart/deleteMulti',
            {cartIds: ids.join(',')}, 'POST',
            function(res){ if(res.success) location.reload(); });
    });
}

function deleteItem(idx){
    showConfirm('삭제하시겠습니까?', function(){
        ajaxRequest('${pageContext.request.contextPath}/payment/cart/delete',
            {cartIdx: idx}, 'POST',
            function(res){ if(res.success) location.reload(); });
    });
}

function gotoCheckout(){
    var ids = [];
    $('.chk-item:checked').each(function(){ ids.push($(this).val()); });
    if(!ids.length){ showAlert('구매할 항목을 선택해주세요.'); return; }
    location.href = '${pageContext.request.contextPath}/payment/checkout?cartIds=' + ids.join(',');
}

//총금액 계산 0428 0143
function calcTotal(){
    var total = 0;
    $('.chk-item:checked').each(function(){
        var row = $(this).closest('tr');
        var priceText = row.find('td:eq(3)').text().replace(/[^0-9]/g, '');
        total += parseInt(priceText) || 0;
    });
    $('#totalPrice').text(total.toLocaleString() + '원');
}

$(function(){
    // 체크박스 변경시 총금액 업데이트
    $(document).on('change', '.chk-item, .chk-all', function(){
        if($(this).hasClass('chk-all')){
            $('.chk-item').prop('checked', $(this).is(':checked'));
        }
        calcTotal();
    });
});
</script>
