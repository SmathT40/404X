<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>페이지를 찾기 싫습니다. - 404</title>
    <style>
        /* 배경 이미지 설정 */
        body {
            /* 1. 이미지 경로 설정 (상대경로 혹은 외부 URL) */
            background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), 
                              url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmMJ1TlCNtVMDS7EIa7cPM7NTyBVeIstnbOw&s');
            
            /* 2. 배경 설정 핵심 */
            background-size: cover;      /* 이미지가 화면을 꽉 채우도록 조절 */
            background-position: center; /* 이미지의 중앙을 기준으로 배치 */
            background-attachment: fixed; /* 스크롤해도 배경은 고정 */
            background-repeat: no-repeat; /* 이미지 반복 방지 */
            
            /* 3. 레이아웃 설정 */
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff; /* 배경이 어두워질 테니 글자색은 흰색으로 */
        }

        .error-container { 
            text-align: center; 
            font-family: 'Pretendard', sans-serif;
            /* 배경 위에서 글자가 잘 보이도록 약간의 그림자 추가 */
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
        }
        
        .error-code { font-size: 100px; font-weight: 900; color: #ff4d4d; margin-bottom: 10px; }
        .error-msg { font-size: 24px; color: #ddd; margin-bottom: 30px; }
        
        .home-btn { 
            padding: 14px 28px; background: #fff; color: #111; 
            text-decoration: none; border-radius: 30px; font-weight: 700;
            transition: 0.3s;
        }
        
        .home-btn:hover {
            background: #ff4d4d;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">404</div>
        <div class="error-msg">요청하신 페이지를 찾기 싫습니다.</div>
        <p>입력하신 주소가 정확한지 다시 한번 확인해주세요.</p>
        <p style="opacity: 0.7;">사실 니가 코딩을 잘못했겠지</p>
        <br>
        <a href="${pageContext.request.contextPath}/" class="home-btn">메인으로 돌아가기</a>
    </div>
</body>
</html>