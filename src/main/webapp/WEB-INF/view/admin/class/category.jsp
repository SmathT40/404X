<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>카테고리 관리 - 404 X CLUB</title>

<div class="row">

    <%-- 1. 왼쪽: 카테고리 목록 (아코디언 적용) --%>
    <div class="col-md-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white d-flex justify-content-between align-items-center border-bottom">
                <h6 class="m-0 font-weight-bold text-dark">카테고리 목록</h6>
                <button type="button" onclick="initForm()" class="btn btn-sm btn-outline-primary">+ 카테고리 추가</button>
            </div>
            <%-- 스크롤바 제거를 위해 max-height 삭제 --%>
            <div class="card-body p-0">
                <div id="categoryAccordion" class="list-group list-group-flush">
                    
                    <c:forEach var="item" items="${categoryList}">
                        <c:if test="${empty item.parent_code}">
                            <%-- 대분류 아이템 --%>
                            <div class="list-group-item list-group-item-action bg-light p-0 border-bottom">
                                <div class="d-flex align-items-center p-3" 
                                     style="cursor:pointer;" 
                                     onclick="toggleSubMenu(this, '${item.category_code}', '${item.category_name}')">
                                    <span class="mr-2 icon-arrow">▶</span>
                                    <strong>📁 ${item.category_name}</strong>
                                    <small class="text-muted ml-auto">(${item.category_code})</small>
                                </div>
                                
                                <%-- 소분류 영역 (평소에는 숨김) --%>
                                <div class="sub-category-wrapper shadow-inner" id="sub-${item.category_code}" style="display:none; background-color: #ffffff;">
                                    <c:forEach var="sub" items="${categoryList}">
                                        <c:if test="${sub.parent_code == item.category_code}">
                                            <div class="list-group-item list-group-item-action border-0 pl-5 py-2" 
                                                 onclick="event.stopPropagation(); fillForm('${sub.category_code}', '${sub.category_name}', '${sub.parent_code}')">
                                                <span class="text-muted mr-2">ㄴ</span> 📄 ${sub.category_name}
                                                <small class="text-muted float-right">${sub.category_code}</small>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    
                </div>
            </div>
        </div>
    </div>

    <%-- 2. 오른쪽: 관리 폼 --%>
    <div class="col-md-6">
        <div class="card shadow-sm">
            <div class="card-header bg-white">
                <h6 class="m-0 font-weight-bold text-dark" id="form_title">새 카테고리 추가</h6>
            </div>
            <div class="card-body">
                <form id="categoryForm">
                    <div class="form-group mb-3">
                        <label class="form-label font-weight-bold">분류</label>
                        <select name="parent_code" id="form_parent_code" class="form-control">
                            <option value="0">대분류</option>
                            <c:forEach var="main" items="${categoryList}">
                                <c:if test="${empty main.parent_code}">
                                    <option value="${main.category_code}">${main.category_name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                        <small class="text-muted">대분류를 등록하려면 '대분류'를 선택하세요.</small>
                    </div>

                    <div class="form-group mb-3">
                        <label class="form-label font-weight-bold">분류 코드</label>
                        <input type="number" name="category_code" id="form_category_code" class="form-control" required placeholder="숫자 코드 입력">
                    </div>

                    <div class="form-group mb-4">
                        <label class="form-label font-weight-bold">분류명</label>
                        <input type="text" name="category_name" id="form_category_name" class="form-control" required placeholder="예: 자바, 스프링">
                    </div>
                    
                    <%-- 버튼 영역 --%>
                    <div class="d-flex justify-content-between border-top pt-3">
                        <button type="button" id="btn_del" onclick="fn_delete()" class="btn btn-outline-danger" style="display:none;">삭제</button>
                        <div class="ml-auto">
						<button type="button" onclick="fn_save()" class="btn btn-primary" id="btn_save" style="min-width: 100px;">등록</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
html {
        overflow-y: scroll;
    }
.list-group-item.active {
    background-color: #f8f9fc !important; /* bg-light와 동일한 색상 */
    border-color: rgba(0,0,0,.125) !important; /* 기본 테두리 색상 */
    color: #4e73df !important; /* 강조하고 싶다면 텍스트만 파란색, 검정색을 원하면 #5a5c69 */
}

select.form-control {
    height: auto !important;
}

.list-group-item.active, 
.list-group-item.active:focus, 
.list-group-item.active:hover {
    z-index: 2;
    outline: none;
    box-shadow: none;
}

/* 화살표 애니메이션 */
.icon-arrow {
    display: inline-block;
    transition: transform 0.3s;
    font-size: 0.7rem;
    color: #ccc;
}
.active .icon-arrow {
    transform: rotate(90deg);
    color: #000;
}
.shadow-inner {
    box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
}

/* 리스트 가독성 */
.list-group-item-action:hover {
    background-color: #f1f3f9 !important;
}
</style>

<script>
//아코디언 토글 기능
function toggleSubMenu(element, code, name) {
    const $this = $(element);
    const $wrapper = $this.next('.sub-category-wrapper');
    
    // 클릭한 대분류 정보를 폼에 채우기 (수정 모드 지원)
    fillForm(code, name, 0);

    // 현재 클릭한 메뉴 토글
    $wrapper.slideToggle(300);
    $this.parent().toggleClass('active');
}

// 폼 채우기
function fillForm(code, name, parent) {
    $('#form_title').text('카테고리 정보 수정');
    $('#form_category_code').val(code).attr('readonly', true);
    $('#form_category_name').val(name);
    $('#form_parent_code').val(parent ? parent : 0);
    $('#btn_del').show();
    $('#btn_save').text('수정');
}

// 신규 추가 시 초기화
function initForm() {
    $('#form_title').text('새 카테고리 추가');
    $('#form_category_code').val('').attr('readonly', false);
    $('#form_category_name').val('');
    $('#form_parent_code').val(0);
    $('#btn_del').hide();
    $('#btn_save').text('추가');
}


//카테고리 저장
function fn_save() {
    if(!$('#form_category_code').val() || !$('#form_category_name').val()) {
        showAlert('모든 항목을 입력해주세요.'); // alert -> showAlert
        return;
    }

    const formData = $('#categoryForm').serialize();
    
    const isUpdate = $('#form_category_code').prop('readonly');
    const url = isUpdate ? '/category/admin/update' : '/category/admin/add';
    const msg = isUpdate ? '수정하시겠습니까?' : '저장하시겠습니까?';

    // confirm -> showConfirm (확인 버튼 클릭 시에만 이후 로직 실행)
    showConfirm(msg, function() {
        $.post('${pageContext.request.contextPath}' + url, formData, function(res) {
            if(res === 'success') {
                showAlert(isUpdate ? '수정되었습니다.' : '저장되었습니다.', function() {
                    location.reload();
                });
            } else {
                showAlert('처리에 실패했습니다. 서버 로그를 확인하세요.');
            }
        });
    });
}

// 카테고리 제거
function fn_delete() {
    const code = $('#form_category_code').val();
    
    const msg = '정말 삭제하시겠습니까? \n 하위 카테고리가 있는 대분류는 삭제되지 않을 수 있습니다.';
    
    showConfirm(msg, function() {
        $.post('${pageContext.request.contextPath}/category/admin/delete', { category_code: code }, function(res) {
            if(res === 'success') {
                showAlert('삭제되었습니다.', function() {
                    location.reload();
                });
            } else {
                showAlert('삭제 실패. 하위 데이터가 있는지 확인하세요.');
            }
        });
    });
}
</script>
