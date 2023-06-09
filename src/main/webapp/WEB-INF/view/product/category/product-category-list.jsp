<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/asset/css/admin/product-category.css">

<style>
    .highlight {
        color: red;
        font-weight: bold;
    }
</style>

<div id="category-div-wrap">
    <div class="basic-select-box">
        <div class="select-box-desc">
            <h2>1차 카테고리</h2>
        </div>
        <select size="10" id="category-select-first" class="category-select-box" data-depth="1">
            <c:forEach items="${categoryList}" var="category">
                <option value="${category.product_category_seq}">${category.product_category_nm}</option>
            </c:forEach>
        </select>
        <span class="border-focus"><i></i></span>
        <button type="button" class="common-btn submit-btn" aria-label="title" data-tasktype="insert"><span>추가</span></button>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="update"><span>수정</span></button>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="delete"><span>삭제</span></button>
    </div>
    <div class="basic-select-box" style="margin: 0 5%">
        <div class="select-box-desc">
            <h2>2차 카테고리</h2>
        </div>
        <select id="category-select-second" size="10" class="category-select-box" data-depth="2">
        </select>
        <span class="border-focus"><i></i></span>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="insert"><span>추가</span></button>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="update"><span>수정</span></button>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="delete"><span>삭제</span></button>
    </div>
    <div class="basic-select-box">
        <div class="select-box-desc">
            <h2>3차 카테고리</h2>
        </div>
        <select id="category-select-third" size="10" class="category-select-box" data-depth="3">
        </select>
        <span class="border-focus"><i></i></span>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="insert"><span>추가</span></button>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="update"><span>수정</span></button>
        <button type="button" class="common-btn submit-btn disabled" aria-label="title" data-tasktype="delete"><span>삭제</span></button>
    </div>
</div>

<script>
    let selectedCategoryDepth;
    let selectedCategorySeq;
    $(".category-select-box").on('change', function () {
        $(this).siblings('button[data-tasktype=update]').removeClass('disabled');
        $(this).siblings('button[data-tasktype=delete]').removeClass('disabled');

        selectedCategorySeq = $(this).find('option:selected').val();
        selectedCategoryDepth = $(this).data('depth');
        let targetSelectBoxes = [];
        if (selectedCategoryDepth === 1) {
            targetSelectBoxes.push($('#category-select-second'));
            targetSelectBoxes.push($('#category-select-third'));
        } else if (selectedCategoryDepth === 2) {
            targetSelectBoxes.push($('#category-select-third'));
        }

        $.ajax({
            url: "/product/category/get-child-category-ajax?categorySeq=" + selectedCategorySeq
            , type: "GET"
            , success: function (data) {
                if (targetSelectBoxes.length > 0) {
                    $.each(targetSelectBoxes, function () {
                        $(this).empty();
                        $(this).siblings('.submit-btn').addClass('disabled')
                    });
                    $(targetSelectBoxes[0]).siblings('button[data-tasktype=insert]').removeClass('disabled');
                    for (let i = 0; i < data.length; i++) {
                        $(targetSelectBoxes[0]).append("<option value='" + data[i].product_category_seq + "'>" + data[i].product_category_nm + "</option>");
                    }
                }
            }
        })
    });

    // 전송할 카테고리 정보가 담기는 객체. 최상위 Depth 면 length = 0
    let sendingCategoryObj = {};
    let clickedBtnCategoryDepth;
    let clickedBtnWrap;
    $('.submit-btn').on('click', function () {
        let isShowPopupInput = true;
        clickedBtnCategoryDepth = $(this).siblings('.category-select-box').data('depth');
        clickedBtnWrap = $(this).parent();
        let taskType = $(this).data('tasktype');
        let taskTypeNm = $(this).text();
        let popupMsg = '';
        sendingCategoryObj.task_type = taskType;
        sendingCategoryObj.task_type_nm = taskTypeNm;

        // Insert = 부모 카테고리 기준
        if (taskType === 'insert') {
            let prevSelectBoxDiv = $(this).parent().prev();
            // 이전 Depth 존재 여부. false 이면 최상위 Depth
            let isExistPrevSelectBox = $(prevSelectBoxDiv).length > 0;

            if (isExistPrevSelectBox) {
                let prevSelectBox = $(prevSelectBoxDiv).find('.category-select-box');
                sendingCategoryObj.parent_depth = $(prevSelectBox).data('depth');
                sendingCategoryObj.parent_name = $(prevSelectBox).find('option:selected').text();
                sendingCategoryObj.parent_seq = $(prevSelectBox).find('option:selected').val();
                // popupMsg = '<p class="msg-tit"><span class="highlight">' + sendingCategoryObj.parent_depth + '차</span> 카테고리 <span class="highlight"> [' + sendingCategoryObj.parent_name + '] </span> 하위 카테고리를 추가합니다. </p>';
                popupMsg = sendingCategoryObj.parent_depth + '차 카테고리 [' + sendingCategoryObj.parent_name + '] 하위 카테고리를 추가합니다.';
            } else {
                sendingCategoryObj.parent_depth = 0;
                sendingCategoryObj.parent_name = null;
                sendingCategoryObj.parent_seq = null;
                // popupMsg = '<p class="msg-tit"><span class="highlight"> 최상위 </span> 카테고리를 추가합니다.';
                popupMsg = '최상위 카테고리를 추가합니다.';
            }
        } else {
            let currentSelectBox = $(this).siblings('.category-select-box');

            sendingCategoryObj.current_seq = $(currentSelectBox).find('option:selected').val();
            sendingCategoryObj.current_name = $(currentSelectBox).find('option:selected').text();
            sendingCategoryObj.depth = $(currentSelectBox).data('depth');

            // popupMsg = '<p class="msg-tit"><span class="highlight">' + sendingCategoryObj.depth + '차</span> 카테고리 <span class="highlight"> [' + sendingCategoryObj.current_name + '] </span> 를 <span class="highlight"> ' + taskTypeNm + ' </span> 하시겠습니까? </p>';
            popupMsg = sendingCategoryObj.depth + '차 카테고리 [' + sendingCategoryObj.current_name + '] 를 ' + taskTypeNm + '하시겠습니까?';
            if (taskType === 'delete') {
                isShowPopupInput = false;
            }
        }

        action_popup.confirm(popupMsg, isShowPopupInput, function (res) {
            if (res) {
                let clickedBtnPrevWrap = $(clickedBtnWrap).prev();
                let clickedBtnNextWrapArr = $(clickedBtnWrap).nextAll('.basic-select-box');
                sendingCategoryObj.current_name = $('#confirm-popup-input').val();

                $.ajax({
                    url: "/product/category/submit"
                    , type: "POST"
                    , contentType: 'application/json; charset=utf-8'
                    , data: JSON.stringify(sendingCategoryObj)
                    , success: function (data) {
                        if (data === true) {
                            let searchCategorySeq;
                            if (clickedBtnCategoryDepth === 1) {
                                searchCategorySeq = 0;
                            } else {
                                searchCategorySeq = $(clickedBtnPrevWrap).find('.category-select-box').find('option:selected').val();
                            }

                            $.ajax({
                                url: "/product/category/get-child-category-ajax?categorySeq=" + searchCategorySeq
                                , type: "GET"
                                , success: function (data) {
                                    // modalPopupClose('#exPopMsg02');

                                    $("select[data-depth=" + clickedBtnCategoryDepth + "]").empty();
                                    for (let i = 0; i < data.length; i++) {
                                        $("select[data-depth=" + clickedBtnCategoryDepth + "]").append("<option value='" + data[i].product_category_seq + "'>" + data[i].product_category_nm + "</option>");
                                    }

                                    // 삭제일때는 하위카테고리 셀렉트박스까지 비우기
                                    if (sendingCategoryObj.task_type === 'delete') {
                                        console.log(clickedBtnNextWrapArr);
                                        for (let i = 0; i < clickedBtnNextWrapArr.length; i++) {
                                            $(clickedBtnNextWrapArr[i]).find('.category-select-box').empty();
                                            $(clickedBtnNextWrapArr[i]).find('.submit-btn').addClass('disabled');
                                        }
                                    }

                                    action_popup.alert(sendingCategoryObj.task_type_nm + ' 되었습니다.')
                                }
                            })
                        } else {
                            action_popup.alert(sendingCategoryObj.task_type_nm + ' 실패하였습니다. 다시 시도해주세요.');
                        }
                    }
                });
            }
        });
    })
</script>
