<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>강사소개 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.instructor-card { padding: 32px 0; border-bottom: 1px solid #eee; }
.instructor-card:last-child { border-bottom: none; }
.instructor-profile { display: flex; gap: 24px; margin-bottom: 20px; }
.instructor-photo { width: 160px; min-width: 160px; height: 160px; background: #ddd; border-radius: 8px; overflow: hidden; }
.instructor-photo img { width: 100%; height: 100%; object-fit: cover; }
.instructor-info { flex: 1; }
.instructor-subject { font-size: 14px; font-weight: 700; color: #3b6d11; margin-bottom: 4px; }
.instructor-name { font-size: 20px; font-weight: 700; margin-bottom: 10px; }
.instructor-quote { font-size: 15px; font-style: italic; color: #555; border-left: 3px solid #3b6d11; padding-left: 12px; margin-bottom: 12px; }
.instructor-desc { font-size: 13px; color: #666; line-height: 1.8; }
/* 강의 썸네일 슬라이더 */
.lecture-slider { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-top: 16px; }
.lecture-thumb { background: #ddd; height: 130px; border-radius: 8px; overflow: hidden; }
.lecture-thumb img { width: 100%; height: 100%; object-fit: cover; }
</style>

<main class="content-area">
<div class="user-content" style="max-width:900px;">

    <h2 style="font-size:22px;font-weight:700;margin-bottom:24px;padding-bottom:12px;border-bottom:2px solid #222;">강사소개</h2>


<c:choose>
        <c:when test="${not empty instructorList}">
            <c:forEach var="instr" items="${instructorList}">
                <div class="instructor-card">
                    <div class="instructor-profile">
                        <div class="instructor-photo">
                            <c:if test="${not empty instr.hostProfileImg}">
                                <img src="${instr.hostProfileImg}" alt="${instr.userName}">
                            </c:if>
                        </div>
                        <div class="instructor-info">
                            <div class="instructor-subject">IT 전문 개발자</div>
                            
                            <div class="instructor-name">${instr.userName} 강사</div>
                            
                            <div class="instructor-quote">${instr.hostIntro}</div>
                            
                            <div class="instructor-desc">${instr.hostDescription}</div>
                        </div>
                    </div>
                    <%-- 강의 썸네일 --%>
                    <div class="lecture-slider">
                        <c:forEach var="lec" items="${instr.classList}">
                            <div class="lecture-thumb">
                                <c:if test="${not empty lec.clsThumbnail}">
                                    <img src="${lec.clsThumbnail}" alt="${lec.clsTitle}">
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div style="padding: 50px; text-align: center; color: #666;">
                <h3>등록된 강사가 없습니다.</h3>
            </div>
        </c:otherwise>
    </c:choose>
    
<%-- 
    <c:choose>
        <c:when test="${not empty instructorList}">
            <c:forEach var="instr" items="${instructorList}">
                <div class="instructor-card">
                    <div class="instructor-profile">
                        <div class="instructor-photo">
                            <c:if test="${not empty instr.profileImg}">
                                <img src="${instr.profileImg}" alt="${instr.userName}">
                            </c:if>
                        </div>
                        <div class="instructor-info">
                            <div class="instructor-subject">${instr.subject} 개발자</div>
                            <div class="instructor-name">${instr.userName} 강사</div>
                            <div class="instructor-quote">${instr.quote}</div>
                            <div class="instructor-desc">${instr.description}</div>
                        </div>
                    </div>
        
                    <div class="lecture-slider">
                        <c:forEach var="lec" items="${instr.classList}">
                            <div class="lecture-thumb">
                                <c:if test="${not empty lec.clsThumbnail}">
                                    <img src="${lec.clsThumbnail}" alt="${lec.clsTitle}">
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <%-- 더미 
            <c:forEach begin="1" end="2">
                <div class="instructor-card">
                    <div class="instructor-profile">
                        <div class="instructor-photo"></div>
                        <div class="instructor-info">
                            <div class="instructor-subject">JAVA 금융분야 개발자</div>
                            <div class="instructor-name">김명신 강사</div>
                            <div class="instructor-quote">기본이 탄탄한 IT 개발자로 키워 드립니다.</div>
                            <div class="instructor-desc">
                                천리길도 한걸음부터.<br>
                                점점 다양해지고, 새로운 개념이 계속 나오는 IT 개발 환경에서 개발자로서 새로운 개념을 스스로 배울 수 있는 힘을 길러 주고자 합니다.
                            </div>
                        </div>
                    </div>
                    <div class="lecture-slider">
                        <div class="lecture-thumb"></div>
                        <div class="lecture-thumb"></div>
                        <div class="lecture-thumb"></div>
                    </div>
                </div>
            </c:forEach>

        </c:otherwise>
    </c:choose>
 --%>

</div>
</main>
