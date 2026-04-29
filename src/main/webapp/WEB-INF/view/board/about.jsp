<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>학원소개 - 404 X CLUB</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="content-area">
<div class="user-content" style="max-width:900px;">

    <h2 style="font-size:22px;font-weight:700;margin-bottom:16px;padding-bottom:12px;border-bottom:1px solid #eee;">학원소개</h2>

    <%-- 소개 본문 --%>
    <div style="line-height:1.9;font-size:14px;color:#333;margin-bottom:48px;">
        <c:choose>
            <c:when test="${not empty aboutContent}">
                ${aboutContent}
            </c:when>
            <c:otherwise>
                404 X CLUB은 실무 중심의 IT 교육 플랫폼입니다.<br>
                최고의 강사진과 함께 JAVA, Python, C#, C++ 등 다양한 과목을 수강하실 수 있습니다.
            </c:otherwise>
        </c:choose>
    </div>
    <%-- 오시는 길 --%>
    <h3 style="font-size:18px;font-weight:700;margin-bottom:16px;padding-bottom:10px;border-bottom:1px solid #eee;">오시는길</h3>

    <%-- 지도 영역 (Google Maps / 카카오맵 API 연동) --%>
    <%-- 
	<div id="map" style="width:100%;height:350px;background:#f5f5f5;border-radius:10px;margin-bottom:24px;border:1px solid #eee;"></div>
	 --%>
	<div id="map" style="width:100%; height:450px; border-radius:12px; border:1px solid #ddd;"></div>
	
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAHboWu4NHSUfn6dDZmgq2OPteL4OPoviY&callback=initMap&v=weekly&loading=async"></script>
	<script>
	    async function initMap() {
	        const myLocation = { lat: 37.476623, lng: 126.880175 }; // 학원 좌표
	
	        // 마커 라이브러리 로드 
	        const { Map } = await google.maps.importLibrary("maps");
	        const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
	
	        const map = new Map(document.getElementById('map'), {
	            zoom: 17,
	            center: myLocation,
	            mapId: "DEMO_MAP_ID", 
	        });
	
	        // 마커 생성
	        const marker = new AdvancedMarkerElement({
	            map: map,
	            position: myLocation,
	            title: "404 X CLUB",
	        });
	    }
	</script>
    <%-- 주소/연락처 --%>
    <table style="width:100%;font-size:14px;border-collapse:collapse;">
        <tr style="border-bottom:1px solid #eee;">
            <td style="padding:14px 0;color:#888;width:80px;display:flex;align-items:center;gap:6px;">
                <span>&#128205;</span> Address
            </td>
            <td style="padding:14px 16px;color:#333;">
                ${aboutInfo.address != null ? aboutInfo.address : '서울특별시 금천구 가산디지털2로 95 KM타워'}
            </td>
        </tr>
        <tr style="border-bottom:1px solid #eee;">
            <td style="padding:14px 0;color:#888;">
                <span>&#128222;</span> Tel
            </td>
            <td style="padding:14px 16px;color:#333;">
                ${aboutInfo.tel != null ? aboutInfo.tel : '+82 2 111 2223'}
            </td>
        </tr>
        <tr style="border-bottom:1px solid #eee;">
            <td style="padding:14px 0;color:#888;">
                <span>&#128242;</span> Fax
            </td>
            <td style="padding:14px 16px;color:#333;">
                ${aboutInfo.fax != null ? aboutInfo.fax : '+82 2 111 2222'}
            </td>
        </tr>
        <tr>
            <td style="padding:14px 0;color:#888;">
                <span>&#128140;</span> Email
            </td>
            <td style="padding:14px 16px;">
                <a href="mailto:${aboutInfo.email != null ? aboutInfo.email : '404xclubadmin@xclub.com'}"
                   style="color:#e63946;">
                    ${aboutInfo.email != null ? aboutInfo.email : '404xclubadmin@xclub.com'}
                </a>
            </td>
        </tr>
    </table>

</div>
</main>
