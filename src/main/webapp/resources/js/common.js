/* =============================================
   404 X CLUB - common.js
   jQuery 공통 함수 모음
   ============================================= */

$(document).ready(function () {

    /* ==============================
       맨 위로 버튼 - 스크롤 감지
       ============================== */
    $(window).scroll(function () {
        if ($(this).scrollTop() > 200) {
            $('#scroll-top').fadeIn(200);
        } else {
            $('#scroll-top').fadeOut(200);
        }
    });

    /* ==============================
       GNB 드롭다운 - hover 보조 (CSS로도 처리되지만 jQuery 보완)
       ============================== */
    $('.gnb-item').hover(
        function () { $(this).find('.gnb-dropdown').stop(true, true).fadeIn(150); },
        function () { $(this).find('.gnb-dropdown').stop(true, true).fadeOut(150); }
    );

    /* ==============================
       전체선택 체크박스 연동
       ============================== */
    $(document).on('change', '.chk-all', function () {
        var checked = $(this).is(':checked');
        $(this).closest('table').find('.chk-item').prop('checked', checked);
        updateCheckStyle();
    });

    $(document).on('change', '.chk-item', function () {
        var total   = $(this).closest('table').find('.chk-item').length;
        var checked = $(this).closest('table').find('.chk-item:checked').length;
        $(this).closest('table').find('.chk-all').prop('checked', total === checked);
        updateCheckStyle();
    });

    function updateCheckStyle() {
        $('.chk-item, .chk-all').each(function () {
            var $box = $(this).closest('.cb-wrap');
            if ($(this).is(':checked')) {
                $box.addClass('checked');
            } else {
                $box.removeClass('checked');
            }
        });
    }

});

/* ==============================
   공통 모달 열기
   title   : 모달 제목
   msg     : 모달 본문 메시지
   onConfirm : 확인 콜백 (선택)
   showCancel: 취소 버튼 표시 여부 (기본 false)
   ============================== */
function openModal(title, msg, onConfirm, showCancel) {
    $('#modalTitle').text(title || '알림');
    $('#modalBody').text(msg || '');

    if (typeof onConfirm === 'function') {
        $('#modalConfirmBtn').off('click').on('click', function () {
            closeModal();
            onConfirm();
        });
    } else {
        $('#modalConfirmBtn').off('click').on('click', function () {
            closeModal();
        });
    }

    if (showCancel) {
        $('#modalCancelBtn').show();
    } else {
        $('#modalCancelBtn').hide();
    }

    $('#commonModal').addClass('active');
}

function closeModal() {
    $('#commonModal').removeClass('active');
}

/* ==============================
   공통 Alert (모달 활용)
   ============================== */
function showAlert(msg, callback) {
    openModal('알림', msg, callback, false);
}

/* ==============================
   공통 Confirm (모달 활용)
   ============================== */
function showConfirm(msg, onConfirm) {
    openModal('확인', msg, onConfirm, true);
}

/* ==============================
   공통 AJAX 요청 함수
   url      : 요청 URL
   data     : 전송 데이터 객체
   method   : 'GET' | 'POST' (기본 POST)
   success  : 성공 콜백 function(res)
   fail     : 실패 콜백 function(err) (선택)
   ============================== */
function ajaxRequest(url, data, method, success, fail) {
    $.ajax({
        url     : url,
        type    : method || 'POST',
        data    : data,
        dataType: 'json',
        success : function (res) {
            if (typeof success === 'function') success(res);
        },
        error   : function (xhr, status, err) {
            console.error('[AJAX Error]', status, err);
            if (typeof fail === 'function') {
                fail(err);
            } else {
                showAlert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
            }
        }
    });
}

/* ==============================
   공통 폼 유효성 검사 도우미
   fieldId   : input id
   msg       : 오류 메시지
   return    : true(통과) / false(실패)
   ============================== */
function validateRequired(fieldId, msg) {
    var val = $('#' + fieldId).val();
    if (!val || val.trim() === '') {
        showAlert(msg || '필수 항목을 입력해주세요.');
        $('#' + fieldId).focus();
        return false;
    }
    return true;
}

/* ==============================
   아이디 찾기 팝업
   ============================== */
function openFindId() {
    $('#findIdModal').addClass('active');
}

/* ==============================
   비밀번호 찾기 팝업
   ============================== */
function openFindPw() {
    $('#findPwModal').addClass('active');
}

/* ==============================
   강사등록 팝업 (인증코드 입력)
   ============================== */
function openInstructorRegModal() {
    $('#instructorRegModal').addClass('active');
}

/* ==============================
   회원탈퇴 팝업
   ============================== */
function openWithdrawModal() {
    $('#withdrawModal').addClass('active');
}



