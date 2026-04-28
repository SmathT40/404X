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
        <div class="admin-actions-row">
            <span class="admin-page-title">강좌 목록</span>
            <%-- 강좌 관리 버튼으로 변경 --%>
            <div style="display:flex;gap:8px;">
                <button class="btn btn-ghost btn-sm" onclick="doEditLecture()">강좌수정</button>
                <button class="btn btn-ghost btn-sm" onclick="deleteLectures()">선택삭제</button>
            </div>
        </div>

        <div class="admin-section" style="padding:0;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>차시</th>
                        <th>소속 클래스</th>
                        <th>강좌명(챕터)</th>
                        <th>재생시간</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty lectureList}">
                            <c:forEach var="lec" items="${lectureList}">
                                <tr>
                                    <td>${lec.lec_no}</td>
                                    <%-- 어떤 클래스에 속한 강좌인지 표시 --%>
                                    <td class="text-muted" style="font-size:0.85rem;">[${lec.cls_title}]</td>
                                    <td><strong>${lec.lec_title}</strong></td>
                                    <td>${lec.lec_time}분</td>
                                    <td>
                                    <div style="text-align: right; margin-bottom: 24px; display: flex; justify-content: flex-end; gap: 8px;">
										<a href="${pageContext.request.contextPath}/host/class/lecupdate?lec_id=${lec.lec_id}" class="btn btn-black btn-sm">수정</a>
										<a href="${pageContext.request.contextPath}/host/class/lecdelete?lec_id=${lec.lec_id}" class="btn btn-ghost btn-sm">삭제</a></div>
                               		</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="6" style="text-align:center;color:#aaa;padding:30px;">등록된 강좌가 없습니다.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${currentPage}"/>
            <jsp:param name="totalPage"   value="${totalPage}"/>
            <jsp:param name="pageUrl"     value="/host/class/status?page="/>
		</jsp:include>


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
