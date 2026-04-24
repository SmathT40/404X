<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강좌 목록 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="admin-content">
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/host/class/status"
           class="tab-item inactive">클래스 현황</a>
        <a href="${pageContext.request.contextPath}/host/class/list"
           class="tab-item active">전체 클래스</a>
    </div>

    <div class="admin-page">

        <%-- 클래스 정보 헤더 --%>
        <div style="margin-bottom:20px;padding:16px 20px;background:#fff;
                    border:1px solid #eee;border-radius:12px;">
            <div style="font-size:16px;font-weight:700;margin-bottom:4px;">
                ${classVO.title}
            </div>
            <div style="font-size:12px;color:#888;">
                ${classVO.userName} &nbsp;|&nbsp;
                등록일 ${classVO.regDate} &nbsp;|&nbsp;
                <c:choose>
                    <c:when test="${classVO.approveStatus == '승인완료'}">
                        <span class="badge badge-green">승인완료</span>
                    </c:when>
                    <c:when test="${classVO.approveStatus == '승인거절'}">
                        <span class="badge badge-red">승인거절</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-gray">승인대기</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- 강의 목록 --%>
        <div class="admin-actions-row">
            <span class="admin-page-title">강의 목록</span>
            <a href="${pageContext.request.contextPath}/host/class/lectureForm?classId=${classVO.classId}"
               class="btn btn-black btn-sm">강의등록</a>
        </div>

        <div class="admin-section" style="padding:0;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>제목</th>
                        <th>강사명</th>
                        <th>등록일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty classList}">
                            <c:forEach var="lec" items="${classList}">
                                <tr>
                                    <td>${lec.no}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/lecture/watch?id=${lec.lecId}">
                                            ${lec.clsTitle}
                                        </a>
                                    </td>
                                    <td>${lec.userName}</td>
                                    <td>${lec.clsRegDate}</td>
                                    <td style="display:flex;gap:6px;">
                                        <a href="${pageContext.request.contextPath}/host/class/lectureForm?id=${lec.lecId}"
                                           class="btn btn-black btn-sm">수정</a>
                                        <button class="btn btn-ghost btn-sm"
                                                onclick="deleteLecture(${lec.lecId})">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" style="text-align:center;color:#aaa;padding:30px;">
                                    등록된 강의가 없습니다.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <jsp:include page="/WEB-INF/view/common/pagination.jsp">
            <jsp:param name="currentPage" value="${currentPage}"/>
            <jsp:param name="totalPage"   value="${totalPage}"/>
            <jsp:param name="pageUrl"
                value="/host/class/classList?classId=${classVO.classId}&page="/>
		</jsp:include>
        <div style="margin-top:20px;">
            <a href="${pageContext.request.contextPath}/host/class/list"
               class="btn btn-ghost btn-sm">&#8592; 목록으로</a>
        </div>

    </div>
</div>
</div>

<div class="modal-overlay" id="commonModal">
    <div class="modal-box">
        <div class="modal-title" id="modalTitle">알림</div>
        <div class="modal-body"  id="modalBody"></div>
        <div class="modal-actions">
            <button class="btn btn-ghost" id="modalCancelBtn"
                    onclick="closeModal()" style="display:none">취소</button>
            <button class="btn btn-black" id="modalConfirmBtn"
                    onclick="closeModal()">확인</button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script>
function deleteLecture(id){
    showConfirm('강의를 삭제하시겠습니까?', function(){
        ajaxRequest(
            '${pageContext.request.contextPath}/host/class/deleteLecture',
            {lectureId: id}, 'POST',
            function(res){ if(res.success) location.reload(); }
        );
    });
}
</script>
