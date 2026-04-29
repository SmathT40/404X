<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>내 강의 관리 - 404 X CLUB</title>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<div class="admin-content">
    <div class="admin-tab-bar">
        <a href="${pageContext.request.contextPath}/host/class/status" class="tab-item active">클래스 현황</a>
        <a href="${pageContext.request.contextPath}/host/class/list"   class="tab-item inactive">전체 클래스</a>
    </div>

    <div class="admin-page">
        <div class="admin-actions-row">
            <div style="display:flex;gap:8px;">
                <a href="${pageContext.request.contextPath}/host/class/lectureForm" class="btn btn-black btn-sm">+ 새 강좌 등록</a>
            </div>
        </div>

        <div class="admin-section" style="padding:0; background: transparent; border:none;">
            <div id="lectureAccordion">
                <c:choose>
                    <c:when test="${not empty lectureList}">
                        <c:set var="currentClassId" value="0" />
                        
                        <c:forEach var="lec" items="${lectureList}" varStatus="status">
                            <%-- 클래스가 바뀌는 시점 체크 --%>
                            <c:if test="${currentClassId != lec.class_id}">
                                <c:if test="${currentClassId != 0}">
                                    <%-- 이전 클래스의 테이블 닫기 --%>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                                
                                <%-- 새로운 클래스 그룹 시작 --%>
                                <div class="class-group-header d-flex align-items-center justify-content-between" 
                                     onclick="toggleLectures('class-group-${lec.class_id}', this)"
                                     style="cursor:pointer; background:#fff; padding:18px 24px; border:1px solid #eee; border-radius:8px; margin-top:12px; transition: 0.2s;">
                                    <div>
                                        <span class="icon-arrow mr-2">▶</span>
                                        <strong style="font-size:1.1rem;">${lec.cls_title}</strong>
                                        <span class="badge badge-gray ml-2" style="font-weight: 500;">ID: ${lec.class_id}</span>
                                    </div>
                                    <span class="text-muted small">클릭하여 강좌 보기</span>
                                </div>
                                
                                <div id="class-group-${lec.class_id}" class="lecture-wrapper" style="display:none; background:#fff; border:1px solid #eee; border-top:none; border-bottom-left-radius:8px; border-bottom-right-radius:8px;">
                                    <table class="data-table mb-0" style="border:none;">
                                        <thead class="bg-light">
                                            <tr>
                                                <th style="width:80px; padding-left:45px;">차시</th>
                                                <th>강좌명(챕터)</th>
                                                <th style="width:120px;">재생시간</th>
                                                <th style="width:150px; text-align:center;">관리</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                <c:set var="currentClassId" value="${lec.class_id}" />
                            </c:if>

                            <%-- 실제 강좌 데이터 --%>
                            <tr>
                                <td style="padding-left:45px;">${lec.lec_no}</td>
                                <td><span class="text-dark font-weight-bold">${lec.lec_title}</span></td>
                                <td>${lec.lec_time_str}</td>
                                <td>
                                    <div class="d-flex justify-content-center gap-2">
                                        <a href="${pageContext.request.contextPath}/host/class/lecupdate?lec_id=${lec.lec_id}" class="btn btn-ghost btn-sm py-1">수정</a>
                                        <a href="javascript:void(0);" onclick="deleteLec('${lec.lec_id}')" class="btn btn-ghost btn-sm py-1 text-danger">삭제</a>
                                    </div>
                                </td>
                            </tr>

                            <%-- 마지막 아이템일 때 태그 닫기 --%>
                            <c:if test="${status.last}">
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center p-5 bg-white border rounded">
                            <p class="text-muted mb-0">등록된 강좌가 없습니다. 클래스에 강좌를 추가해 보세요!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<style>
html {
        overflow-y: scroll;
    }
/* 아코디언 스타일 전용 */
.class-group-header:hover { background-color: #fcfcfc !important; border-color: #ddd !important; }
.class-group-header.active { border-bottom-left-radius: 0 !important; border-bottom-right-radius: 0 !important; border-bottom-color: transparent !important; }
.class-group-header.active .icon-arrow { transform: rotate(90deg); color: #000; }
.icon-arrow { display: inline-block; transition: 0.3s; color: #ccc; font-size: 0.7rem; }
.lecture-wrapper { overflow: hidden; }
.data-table thead th { font-size: 0.85rem; color: #888; border-top: none; }
.gap-2 { gap: 8px; }
</style>

<script>
function toggleLectures(groupId, header) {
    const $target = $('#' + groupId);
    const $header = $(header);
    
    $target.slideToggle(250);
    $header.toggleClass('active');
}

function deleteLec(lecId) {
    if(!confirm('해당 강좌를 삭제하시겠습니까?')) return;
    location.href = '${pageContext.request.contextPath}/host/class/lecdelete?lec_id=' + lecId;
}
</script>