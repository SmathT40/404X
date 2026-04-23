<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid py-4 px-5">
    <div class="mb-3">
        <h4 class="font-weight-bold text-secondary" style="font-size: 1.1rem;">
            ${categoryData.category_name} <span class="text-muted" style="font-size: 0.9rem;">학습과정</span>
        </h4>
        <hr class="m-0" style="width: 40px; border-top: 2px solid #dee2e6;">
    </div>

    <div class="d-flex flex-wrap mb-4" id="subCategoryGroup">
        <c:choose>
            <%-- 하위 카테고리가 존재하는 경우 --%>
            <c:when test="${not empty categoryData.subList}">
                <c:forEach var="sub" items="${categoryData.subList}">
                    <button type="button" 
                            class="btn btn-outline-dark btn-sm mr-2 mb-2 px-3 py-1 cate-btn" 
                            data-code="${sub.category_code}"
                            style="border-radius: 20px; font-weight: 500; font-size: 0.9rem;">
                        ${sub.category_name}
                    </button>
                </c:forEach>
            </c:when>
            
            <%-- 하위 카테고리가 하나도 없는 경우 --%>
            <c:otherwise>
                <div class="col-12 py-3 px-0">
                    <div class="alert alert-light border-0 bg-light shadow-sm d-flex align-items-center" style="border-radius: 10px;">
                        <i class="fas fa-exclamation-circle text-warning mr-3"></i>
                        <span class="text-muted" style="font-size: 0.9rem;">
                            현재 등록된 세부 학습 과정이 없습니다. 곧 준비하도록 하겠습니다.
                        </span>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div id="courseListArea" class="mt-2 pt-4 border-top">
        <c:if test="${not empty categoryData.subList}">
            <div class="text-center py-5 text-muted">
                <p style="font-size: 0.9rem;">위의 세부 카테고리를 선택하면 전체 커리큘럼이 표시됩니다.</p>
            </div>
        </c:if>
    </div>
</div>