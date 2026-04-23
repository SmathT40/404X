-- 1. 사용자 및 강사 정보 테이블
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,          -- 아이디 (UserVO.userId)
    user_pw VARCHAR(255) NOT NULL,            -- 비밀번호 (BCrypt 암호화)
    user_name VARCHAR(50) NOT NULL,           -- 이름
    user_birth CHAR(8),                       -- 생년월일 (YYYYMMDD)
    user_phone VARCHAR(20),                   -- 전화번호
    user_email VARCHAR(100) NOT NULL,         -- 이메일
    user_role VARCHAR(10) DEFAULT 'USER',     -- 권한 (USER/HOST/ADMIN)
    profile_img VARCHAR(255),                 -- 프로필 이미지 경로
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP, -- 가입일
    use_yn CHAR(1) DEFAULT 'Y',               -- 사용여부 (Y/N)
    -- 강사 전용 정보 (HostRequestVO 및 UserVO 강사필드)
    host_intro VARCHAR(255),                  -- 강사 한줄 소개
    host_subject VARCHAR(100),                -- 강의 과목
    host_description TEXT,                    -- 상세 소개 (description)
    bank_name VARCHAR(50),                    -- 은행명
    account_no VARCHAR(50),                   -- 계좌번호
    account_name VARCHAR(50)                  -- 예금주명
);

-- 2. 카테고리 테이블 (교육과정 및 소분류 관리)
CREATE TABLE category (
    cat_code INT AUTO_INCREMENT PRIMARY KEY,
    cat_name VARCHAR(100) NOT NULL,
    parent_code INT,                          -- 상위 카테고리 (Self-Join)
    FOREIGN KEY (parent_code) REFERENCES category(cat_code)
);

-- 3. 클래스 테이블 (ClassVO)
CREATE TABLE cls (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    instructor_id VARCHAR(50) NOT NULL,       -- 강사 아이디
    cat_code INT,                             -- 카테고리 코드
    title VARCHAR(200) NOT NULL,              -- 클래스 제목
    price INT DEFAULT 0,                      -- 가격
    thumbnail VARCHAR(255),                   -- 썸네일 경로
    content TEXT,                             -- 설명 (HTML)
    open_yn CHAR(1) DEFAULT 'Y',              -- 공개여부
    approve_status VARCHAR(20) DEFAULT 'WAIT', -- 승인상태
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES users(user_id),
    FOREIGN KEY (cat_code) REFERENCES category(cat_code)
);

-- 4. 개별 강의/차시 테이블 (LectureVO)
CREATE TABLE lec (
    lec_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,                    -- 소속 클래스
    lec_title VARCHAR(200) NOT NULL,          -- 강의 제목
    video_path VARCHAR(255),                  -- 동영상 경로
    lec_content TEXT,                         -- 강의 설명
    lec_no INT DEFAULT 0,                     -- 강의 차시
    FOREIGN KEY (class_id) REFERENCES cls(class_id) ON DELETE CASCADE
);

-- 5. 게시판 테이블 (BoardVO)
CREATE TABLE board (
    board_id INT AUTO_INCREMENT PRIMARY KEY,
    board_type VARCHAR(20) NOT NULL,          -- NOTICE/FREE/INQUIRY/SETTLEMENT
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,