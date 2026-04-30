<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="user-content" style="max-width: 1000px; margin: 40px auto;">
    <div style="margin-bottom: 30px; border-left: 5px solid #4f46e5; padding-left: 20px;">
        <h2 style="font-size: 28px; font-weight: 700;">${leclist[0].cls_title}</h2>
        <p style="color: #666; margin-top: 5px;">학습할 차시를 선택하세요.</p>
    </div>

    <div style="background: #fff; border: 1px solid #eee; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.02);">
        <table style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead style="background: #f9fafb; border-bottom: 2px solid #eee;">
                <tr>
                    <th style="padding: 15px 20px; width: 80px;">차시</th>
                    <th style="padding: 15px 20px;">강좌 제목 및 내용</th>
                    <th style="padding: 15px 20px; width: 100px;">재생 시간</th>
                    <th style="padding: 15px 20px; width: 120px; text-align: center;">학습하기</th>
                </tr>
            </thead>
            <tbody>
                <%-- DB 데이터가 연결되면 c:forEach를 사용하세요 --%>
                <%-- 지금은 구조 확인용 더미 한 줄입니다 --%>
                
                <c:forEach var="lec" items="${leclist}">
                
                    <tr style="border-bottom: 1px solid #f0f0f0; transition: 0.2s;" onmouseover="this.style.backgroundColor='#fcfcff'" onmouseout="this.style.backgroundColor='#fff'">
                        <td style="padding: 20px; font-weight: 700; color: #4f46e5; text-align: center;">${lec.lec_no}강</td>
                        <td style="padding: 20px;">
                            <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px;">${lec.lec_title}</div>
                            <%-- <div style="font-size: 14px; color: #888;">${lec.lec_content}</div> --%>
                        </td>
                        <td style="padding: 20px; color: #666; font-size: 14px;">${lec.lec_time_str}</td>
                        <td style="padding: 20px; text-align: center;">
							<button onclick="checkLoginAndWatch(${lec.class_id}, ${lec.lec_id})" 
							        style="background: #4f46e5; color: #fff; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; font-size: 13px;">
							    시청하기
							</button>
                        </td>
                    </tr>
                   
                </c:forEach>
                 
                
                <c:if test="${empty leclist}">
                    <tr>
                        <td colspan="4" style="padding: 50px; text-align: center; color: #999;">등록된 강좌가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
$(document).ready(function() {
    const msg = "${msg}";
    
    if (msg) {
        openModal('', msg, function() {
        }, false);
    }
});
const loginUser = ${not empty sessionScope.loginUser};
function checkLoginAndWatch(classId, lecId) {
    if (!loginUser) {
        showAlert('로그인이 필요한 서비스입니다.');
        return;
    }
    location.href = '${pageContext.request.contextPath}/class/watch?class_id=' + classId + '&lec_id=' + lecId;
}
</script>