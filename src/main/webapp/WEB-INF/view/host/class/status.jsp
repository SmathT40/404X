<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강의 상태 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>


<div class="admin-content">
    <%-- 탭바 --%>
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/host/class/status" class="tab-item active">클래스 현황</a>
        <a href="${pageContext.request.contextPath}/host/class/list"   class="tab-item inactive">전체 클래스</a>
    </div>

    <div class="admin-page">

        <%-- 검색바 --%>
        <div class="search-bar">
            <input type="text" class="search-input" id="keyword" placeholder="강의명으로 검색..." value="${param.keyword}">
            <button class="search-btn" onclick="doSearch()">검색</button>
        </div>

        <div style="font-size:15px;font-weight:600;margin-bottom:12px;">클래스 승인요청</div>

        <div class="admin-section" style="padding:0;">
            <table class="data-table">
                <tbody>
                    <c:choose>
                        <c:when test="${not empty statusList}">
                            <c:forEach var="cls" items="${statusList}">
                                <tr>
                                    <td>${cls.clsTitle}</td>
                                    <td>${cls.userName}</td>
                                    <td><fmt:formatNumber value="${cls.clsPrice}" pattern="#,###"/>원</td>
                                    <td>${cls.clsRegDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${cls.approveStatus == '승인대기'}"><span class="badge badge-gray">승인대기</span></c:when>
                                            <c:when test="${cls.approveStatus == '승인거절'}"><span class="badge badge-red">승인거절</span></c:when>
                                            <c:when test="${cls.approveStatus == '승인완료'}"><span class="badge badge-green">승인완료</span></c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="5" style="text-align:center;color:#aaa;padding:30px;">등록된 클래스가 없습니다.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${currentPage}"/>
            <jsp:param name="totalPage"   value="${totalPage}"/>
            <jsp:param name="pageUrl"     value="/host/class/status?page="/>
		</jsp:include>
    </div>
</div>

</div>

<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">알림</div>
        <div class="modal-body"  id="modalBody"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn"  onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn" onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
function doSearch(){ location.href='${pageContext.request.contextPath}/host/class/status?keyword=' + encodeURIComponent($('#keyword').val()); }
</script>
