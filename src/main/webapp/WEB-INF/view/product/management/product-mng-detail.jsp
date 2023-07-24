<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<script src="lodash.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
<style>
    #category-div-wrap .basic-select-box select{
        height: 200px !important;
    }

    #category-div-wrap {
        padding-top: 0px;
    }

    #option_input_wrap .input-box {
        display: inline-block;
    }

    #option_input_wrap .option-name-div {
        width: 20%;
        margin-right: 2%;
    }

    #option_input_wrap .option-value-div {
        width: 77%;
    }

    #option_input_wrap .input-box-wrap {
        display: block;
        margin-bottom: 1%;
        margin-top: 1%;
    }

    #option-list-table td{
        text-align: center;
        vertical-align: middle;
    }

    #option-list-table-div {
        width: 100%;
        height: 300px;
        overflow: auto;
    }

     .ck.ck-editor {
         width: 100%;
         margin: 0 auto;
     }

    .ck-editor__editable {
        height: 30vh;
    }

    .option-th {
        background-color: #F6F6FC !important;
        border: 1px solid #E8E8F1;
    }

    .option-td {
        border: 1px solid #E8E8F1;
    }

    .img-list img {
        width: 6vw;
        height: 6vw;
        background-color: #69649c82;
        border-radius: 6px;
        margin: 10px 2px 3px 2px;
    }

    .mini {
        background-color: #bbb;
        width: 60px;
        min-width: 60px;
        padding: 5px;
    }

    .xBtn {
        position: absolute;
        margin-left: -16px;
        margin-top: 13px;
        cursor: pointer;
    }

</style>
<main id="main" class="page-home">
    <div class="admin-section-wrap">
        <form id="frm" name="frm">
            <input type="hidden" id="product-seq" name="productSeq" value="${productDetailInfo.product_seq}"/>
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <%--<input type="hidden" id="memberSeq" name="memberSeq" value="${member.memberSeq}">--%>
                    <table class="common-table" summary="상품상세정보">
                        <colgroup>
                            <col width="15%">
                            <col width="85%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">상품명</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="input-box-wrap">
                                        <div class="input-box text">
                                            <input type="text" id="name" name="product_name" value="${productDetailInfo.product_name}">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">카테고리</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div id="category-div-wrap">
                                        <div class="basic-select-box">
                                            <div class="select-box-desc">
                                                <h2>1차 카테고리</h2>
                                            </div>
                                            <select size="10" id="category-select-first" class="category-select-box" data-depth="1">
                                                <c:choose>
                                                    <c:when test="${regType == 'insert'}">
                                                        <c:forEach items="${topCategoryList}" var="category">
                                                            <option value="${category.product_category_seq}">${category.product_category_nm}</option>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach items="${hierarchicalCategoryList[0].list}" var="category">
                                                            <option value="${category.product_category_seq}"
                                                                <c:if test="${hierarchicalCategoryList[0].seq == category.product_category_seq}">
                                                                    selected
                                                                </c:if>>
                                                                ${category.product_category_nm}
                                                            </option>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <div class="basic-select-box" style="margin: 0 5%">
                                            <div class="select-box-desc">
                                                <h2>2차 카테고리</h2>
                                            </div>
                                            <select id="category-select-second" size="10" class="category-select-box" data-depth="2">
                                                <c:if test="${regType == 'update'}">
                                                    <c:forEach items="${hierarchicalCategoryList[1].list}" var="category">
                                                        <option value="${category.product_category_seq}"
                                                            <c:if test="${hierarchicalCategoryList[1].seq == category.product_category_seq}">
                                                                selected
                                                            </c:if>>
                                                            ${category.product_category_nm}
                                                        </option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <div class="basic-select-box">
                                            <div class="select-box-desc">
                                                <h2>3차 카테고리</h2>
                                            </div>
                                            <select id="category-select-third" size="10" name="category_seq" class="category-select-box" data-depth="3">
                                                <c:if test="${regType == 'update'}">
                                                    <c:forEach items="${hierarchicalCategoryList[2].list}" var="category">
                                                        <option value="${category.product_category_seq}"
                                                            <c:if test="${hierarchicalCategoryList[2].seq == category.product_category_seq}">
                                                                selected
                                                            </c:if>>
                                                            ${category.product_category_nm}
                                                        </option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">옵션</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="has_option" name="is_has_option" value="true" <c:if test="${productDetailInfo.is_has_option == true}">checked</c:if>>
                                            <label for="has_option"><span>설정함</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="has_not_option" name="is_has_option" value="false" <c:if test="${productDetailInfo.is_has_option == false or regType == 'insert'}">checked</c:if>>
                                            <label for="has_not_option"><span>설정안함</span></label>
                                        </div>
                                    </div>
                                    <div id="option-table-div" <c:if test="${regType == 'insert' or productDetailInfo.is_has_option == 'false'}">class="hidden"</c:if>>
                                        <hr/>
                                            <table class="common-table">
                                            <colgroup>
                                                <col width="15%">
                                                <col width="85%">
                                            </colgroup>
                                            <tr>
                                                <th class="row-th" scope="row"><div class="con-th">옵션 수</div></th>
                                                <td class="cell-td dt-left">
                                                    <div class="con-td">
                                                        <div class="basic-select-box">
                                                            <select id="option-count-select">
                                                                <option value="1" <c:if test="${fn:length(productOptionList) == 1}">selected</c:if> >1개</option>
                                                                <option value="2" <c:if test="${fn:length(productOptionList) == 2}">selected</c:if> >2개</option>
                                                                <option value="3" <c:if test="${fn:length(productOptionList) == 3}">selected</c:if> >3개</option>
                                                            </select>
                                                            <span class="border-focus"><i></i></span>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="row-th" scope="row"><div class="con-th">옵션 입력</div></th>
                                                <td class="cell-td dt-left">
                                                    <div class="con-td">
                                                        <div id="option_input_wrap">
                                                            <div class="input-box-wrap" data-index="1">
                                                                <input type="hidden" class="option-seq" value="${productOptionList[0].option_seq}">
                                                                <div class="input-box text option-name-div">
                                                                    <input type="text" class="option-name-input" name="option_name" placeholder="옵션명 (예시: 컬러)" value="${productOptionList[0].option_name}">
                                                                    <span class="border-focus"><i></i></span>
                                                                </div>
                                                                <div class="input-box text option-value-div">
                                                                    <input type="text" class="option-value-input" name="option_value" placeholder="옵션값 (예시: 빨강,노랑,초록)" value="${productOptionList[0].option_detail_name_arr}">
                                                                    <span class="border-focus"><i></i></span>
                                                                </div>
                                                            </div>
                                                            <div class="input-box-wrap <c:if test='${fn:length(productOptionList) < 2}'> hidden </c:if>" data-index="2">
                                                                <input type="hidden" class="option-seq" value="${productOptionList[1].option_seq}">
                                                                <div class="input-box text option-name-div">
                                                                    <input type="text" class="option-name-input" name="option_name" placeholder="옵션명 (예시: 컬러)" value="${productOptionList[1].option_name}">
                                                                    <span class="border-focus"><i></i></span>
                                                                </div>
                                                                <div class="input-box text option-value-div">
                                                                    <input type="text" class="option-value-input" name="option_value" placeholder="옵션값 (예시: 빨강,노랑,초록)" value="${productOptionList[1].option_detail_name_arr}">
                                                                    <span class="border-focus"><i></i></span>
                                                                </div>
                                                            </div>
                                                            <div class="input-box-wrap <c:if test='${fn:length(productOptionList) < 3}'> hidden </c:if>" data-index="3">
                                                                <input type="hidden" class="option-seq" value="${productOptionList[2].option_seq}">
                                                                <div class="input-box text option-name-div">
                                                                    <input type="text" class="option-name-input" name="option_name" placeholder="옵션명 (예시: 컬러)" value="${productOptionList[2].option_name}">
                                                                    <span class="border-focus"><i></i></span>
                                                                </div>
                                                                <div class="input-box text option-value-div">
                                                                    <input type="text" class="option-value-input" name="option_value" placeholder="옵션값 (예시: 빨강,노랑,초록)" value="${productOptionList[2].option_detail_name_arr}">
                                                                    <span class="border-focus"><i></i></span>
                                                                </div>
                                                            </div>
                                                            <div id="convert-option-list-wrap">
                                                                <div class="input-box text" style="width:100%">
                                                                    <button type="button" id="convert-option-list-btn" class="common-btn" aria-label="title" onclick="location.href='#none'" style="width: 100%;"><span style="font-size: 15px;">옵션목록으로 적용 ▼</span></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="row-th" scope="row"><div class="con-th">옵션 목록</div></th>
                                                <td class="cell-td dt-left">
                                                    <div class="con-td">
                                                        <div id="option-list-table-div">
                                                            <table id="option-list-table" class="common-table" summary="옵션목록">
                                                                <colgroup>
                                                                    <c:choose>
                                                                        <c:when test="${regType == 'insert'}">
                                                                            <col width="54%">
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <col width="${54 / fn:length(productOptionList)}%">
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <col width="23%">
                                                                    <col width="23%">
                                                                </colgroup>
                                                                <tr style="background-color: #ebebeb">
                                                                    <td class="option-th" colspan="${fn:length(productOptionList)}">옵션명</td>
                                                                    <td class="option-th" rowspan="2">옵션가</td>
                                                                    <td class="option-th" rowspan="2">재고수량</td>
                                                                </tr>
                                                                <tr id="option-name-tr">
                                                                    <c:forEach var="productOptionList" items="${productOptionList}">
                                                                        <td style="background-color: #ebebeb; border: 1px solid #E8E8F1;">${productOptionList.option_name}</td>
                                                                    </c:forEach>
                                                                </tr>
                                                                <input type="hidden" id="isOptionUpdateYn" name="isOptionUpdateYn" value="<c:choose><c:when test='${empty productCombinationOptionList}'>N</c:when><c:otherwise>Y</c:otherwise></c:choose>">
                                                                <c:forEach var="combinationOption" items="${productCombinationOptionList}">
                                                                    <tr class="option-list-tr">
                                                                        <input type="hidden" class="option_combine_seq" value="${combinationOption.option_combine_seq}">
                                                                        <c:if test="${not empty combinationOption.option_detail_name_1}"><td class="option-td">${combinationOption.option_detail_name_1}</td></c:if>
                                                                        <c:if test="${not empty combinationOption.option_detail_name_2}"><td class="option-td">${combinationOption.option_detail_name_2}</td></c:if>
                                                                        <c:if test="${not empty combinationOption.option_detail_name_3}"><td class="option-td">${combinationOption.option_detail_name_3}</td></c:if>
                                                                        <td class="option-td"><div class="input-box text"><input type="number" class="option-price" value="${combinationOption.additional_price}"></div></td>
                                                                        <td class="option-td"><div class="input-box text"><input type="number" class="option-stock" value="${combinationOption.stock}"></div></td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <hr/>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <!-- 옵션 설정 안했을때만 보여주기 -->
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">재고</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="input-box-wrap">
                                        <div class="input-box text">
                                            <input type="text" id="stock" name="product_stock" <c:if test="${productDetailInfo.is_has_option == true}"> disabled</c:if> <c:if test="${productDetailInfo.is_has_option == false}">value="${productDetailInfo.product_stock}"</c:if> >
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">가격</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="input-box-wrap">
                                        <div class="input-box text">
                                            <input type="text" id="price" name="product_price" value="${productDetailInfo.product_price}">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">할인</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_discount" name="is_discount" value="true" <c:if test="${productDetailInfo.is_discount == true}">checked</c:if> >
                                            <label for="is_discount"><span>설정함</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_not_discount" name="is_discount" value="false" <c:if test="${productDetailInfo.is_discount == false or regType == 'insert'}">checked</c:if>>
                                            <label for="is_not_discount"><span>설정안함</span></label>
                                        </div>
                                        <div id="discount-price-wrap" <c:if test="${productDetailInfo.is_discount == false or regType == 'insert'}">class="hidden"</c:if> >
                                            <hr/>
                                            <span>할인된 금액 : </span>
                                            <div class="input-box text" style="width: 20%; display: inline-block;">
                                                <input type="text" id="discount_price" name="discount_price" <c:if test="${productDetailInfo.is_discount == true}">value="${productDetailInfo.discount_price}"</c:if> >
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            원
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">배송비</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="free" name="delivery_condition" value="free" <c:if test="${productDetailInfo.delivery_charge == 0 or regType == 'insert'}">checked</c:if> >
                                            <label for="free"><span>무료</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="condition" name="delivery_condition" value="condition" <c:if test="${productDetailInfo.is_use_conditional_delivery == true}">checked</c:if> >
                                            <label for="condition"><span>조건부 무료</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="charge" name="delivery_condition" value="charge" <c:if test="${productDetailInfo.is_use_conditional_delivery == false and productDetailInfo.delivery_charge > 0}">checked</c:if> >
                                            <label for="charge"><span>유료</span></label>
                                        </div>
                                        <div id="delivery_condition_wrap" <c:if test="${productDetailInfo.delivery_charge == 0 or productDetailInfo.is_use_conditional_delivery == false or regType == 'insert'}"> class="hidden" </c:if> >
                                            <hr/>
                                            기본 배송비 :
                                            <div class="input-box text" style="width: 20%; display: inline-block;">
                                                <input type="text" class="default-delivery-charge" name="default_delivery_charge_conditional" value="${productDetailInfo.delivery_charge}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            원
                                            <hr/>
                                            배송비 조건 :
                                            <div class="input-box text" style="width: 20%; display: inline-block;">
                                                <input type="text" class="condition-delivery-charge" name="condition_delivery_charge" value="${productDetailInfo.conditional_delivery_price}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            원 이상 주문시 무료
                                        </div>
                                        <div id="delivery_charge_wrap" <c:if test="${productDetailInfo.delivery_charge == 0 or productDetailInfo.is_use_conditional_delivery == true or regType == 'insert'}"> class="hidden" </c:if> >
                                            <hr/>
                                            기본 배송비 :
                                            <div class="input-box text" style="width: 20%; display: inline-block;">
                                                <input type="text" class="default-delivery-charge" name="default_delivery_charge" value="${productDetailInfo.delivery_charge}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            원
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">대표 이미지</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="input-box text file-div">
                                        <span class="file_input">
                                            <label class="common-btn mini" style="background-color: #8f95e4;"> 추가
                                                <input type="file" name="files" onchange="setImageFile(this);" style="display: none;" accept="image/jpeg, image/png, image/jpg"/>
                                            </label>
                                        </span>
                                    </div>
                                    <div id="images_container" class="img-list">
                                        <c:forEach var="thumbnail" items="${fileList}"  varStatus="status">
                                            <div class="thumbnail-div" style="display: inline-block">
                                                <img id="thumbnail_${thumbnail.seq}" class="product-thumbnail" src="../../asset/upload/img${thumbnail.file_path}"/>
                                                <label for="thumbnail_${thumbnail.seq}" class="xBtn">X</label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">상품 상세설명</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <label for="editor"></label><textarea id="editor" name="product_description">${productDetailInfo.product_description}</textarea>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">상품주문 쿠폰</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <input type="hidden" id="product-order-coupon-seq" name="product_order_coupon_seq" <c:if test="${productDetailInfo.is_set_product_order_coupon == true}}">value="${productDetailInfo.product_order_coupon_seq}"</c:if> >
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is-set-product-order-coupon" name="is_set_product_order_coupon" value="true" <c:if test="${productDetailInfo.is_set_product_order_coupon == true}">checked</c:if> >
                                            <label for="is-set-product-order-coupon"><span>설정함</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is-not-set-product-order-coupon" name="is_set_product_order_coupon" value="false" <c:if test="${productDetailInfo.is_set_product_order_coupon == false or regType == 'insert'}">checked</c:if>>
                                            <label for="is-not-set-product-order-coupon"><span>설정안함</span></label>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">구매 포인트</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_pay_but_point" name="is_pay_buy_point" value="true" <c:if test="${productDetailInfo.is_pay_buy_point == true}">checked</c:if> >
                                            <label for="is_pay_but_point"><span>설정함</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_not_pay_buy_point" name="is_pay_buy_point" value="false" <c:if test="${productDetailInfo.is_pay_buy_point == false or regType == 'insert'}">checked</c:if>>
                                            <label for="is_not_pay_buy_point"><span>설정안함</span></label>
                                        </div>
                                    </div>
                                    <div id="pay-buy-point-wrap" <c:if test="${productDetailInfo.is_pay_buy_point == false or regType == 'insert'}">class="hidden"</c:if> >
                                        <hr/>
                                        지급 포인트 :
                                        <div class="input-box text" style="width: 20%; display: inline-block;">
                                            <input type="text" class="pay_buy_point" name="pay_buy_point" value="${productDetailInfo.product_buy_point}">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        포인트
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">텍스트리뷰 포인트</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_pay_normal_review_point" name="is_pay_normal_review_point" value="true" <c:if test="${productDetailInfo.is_pay_normal_review_point == true}">checked</c:if> >
                                            <label for="is_pay_normal_review_point"><span>설정함</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_not_pay_normal_review_point" name="is_pay_normal_review_point" value="false" <c:if test="${productDetailInfo.is_pay_normal_review_point == false or regType == 'insert'}">checked</c:if> >
                                            <label for="is_not_pay_normal_review_point"><span>설정안함</span></label>
                                        </div>
                                    </div>
                                    <div id="pay-normal-review-point-wrap" <c:if test="${productDetailInfo.is_pay_normal_review_point == false or regType == 'insert'}">class="hidden"</c:if> >
                                        <hr/>
                                        지급 포인트 :
                                        <div class="input-box text" style="width: 20%; display: inline-block;">
                                            <input type="text" class="pay_normal_review_point" name="pay_normal_review_point" value="${productDetailInfo.product_normal_review_point}">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        포인트
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">미디어리뷰 포인트</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="radio-box-wrap">
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_pay_media_review_point" name="is_pay_media_review_point" value="true" <c:if test="${productDetailInfo.is_pay_media_review_point == true}">checked</c:if> >
                                            <label for="is_pay_media_review_point"><span>설정함</span></label>
                                        </div>
                                        <div class="basic-radio-box">
                                            <input type="radio" id="is_not_pay_media_review_point" name="is_pay_media_review_point" value="false" <c:if test="${productDetailInfo.is_pay_media_review_point == false or regType == 'insert'}">checked</c:if> >
                                            <label for="is_not_pay_media_review_point"><span>설정안함</span></label>
                                        </div>
                                    </div>
                                    <div id="pay-media-review-point-wrap" <c:if test="${productDetailInfo.is_pay_normal_review_point == false or regType == 'insert'}">class="hidden"</c:if>>
                                        <hr/>
                                        지급 포인트 :
                                        <div class="input-box text" style="width: 20%; display: inline-block;">
                                            <input type="text" class="pay_media_review_point" name="pay_media_review_point" value="${productDetailInfo.product_media_review_point}">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        포인트
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div style="margin-top: 20px; float: right;">
                        <button type="button" id="cancelBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>취소</span></button>
                        <button type="button" id="submitBtn" style="padding: 10px; font-size: 15px;" class="common-btn" aria-label="title"><span><c:choose><c:when test="${regType == 'insert'}">등록</c:when> <c:otherwise>수정</c:otherwise></c:choose></span></button>
                    </div>
                </section>
            </div>
        </form>
    </div>
</main>

<script>

    var editor = createCkEditor('/file/image-upload');

    var regType = '${regType}';
    var regTypeNm = regType === 'insert' ? '등록' : '수정';

    $(".category-select-box").on('change', function () {
        let selectedCategoryDepth;
        let selectedCategorySeq;
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
                    });
                    for (let i = 0; i < data.length; i++) {
                        $(targetSelectBoxes[0]).append("<option value='" + data[i].product_category_seq + "'>" + data[i].product_category_nm + "</option>");
                    }
                }
            }
        })
    });

    // 옵션 여부
    $("input[name='is_has_option']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $('#option-table-div').removeClass('hidden');
            // 옵션 미설정시 재고 활성화
            $('#stock').attr('disabled', true);
        } else {
            $('#option-table-div').addClass('hidden');
            $('#stock').attr('disabled', false);
        }
    });

    // 할인 여부
    $("input[name='is_discount']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $("#discount-price-wrap").removeClass('hidden');
        } else {
            $("#discount-price-wrap").addClass('hidden');
        }
    });

    // 배송비
    $("input[name='delivery_condition']").on('change', function () {
        let value = $(this).val();
        if (value === 'free') {
            $("#delivery_condition_wrap").addClass('hidden');
            $("#delivery_charge_wrap").addClass('hidden');
        } else if (value === 'condition') {
            $("#delivery_condition_wrap").removeClass('hidden');
            $("#delivery_charge_wrap").addClass('hidden');
        } else {
            $("#delivery_condition_wrap").addClass('hidden');
            $("#delivery_charge_wrap").removeClass('hidden');
        }
    });

    // 구매 포인트
    $("input[name='is_pay_buy_point']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $("#pay-buy-point-wrap").removeClass('hidden');
        } else {
            $("#pay-buy-point-wrap").addClass('hidden');
        }
    });

    // 주문 쿠폰
    $("input[name='is_set_product_order_coupon']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            PopupReg1('/promotion/coupon/select-coupon-popup', 800, 400, '_blank')
        }
    });

    // 텍스트리뷰 작성 포인트
    $("input[name='is_pay_normal_review_point']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $("#pay-normal-review-point-wrap").removeClass('hidden');
        } else {
            $("#pay-normal-review-point-wrap").addClass('hidden');
        }
    });

    // 미디어리뷰 작성 포인트
    $("input[name='is_pay_media_review_point']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $("#pay-media-review-point-wrap").removeClass('hidden');
        } else {
            $("#pay-media-review-point-wrap").addClass('hidden');
        }
    });

    // 옵션 수 변경시
    $("#option-count-select").on('change', function () {
        let optionCnt = $(this).val();
        let inputBoxWraps = $("#option_input_wrap .input-box-wrap").not('#convert-option-list-wrap');

        for (let i=0; i<inputBoxWraps.length; i++) {
            if (i < optionCnt) {
                $(inputBoxWraps[i]).removeClass('hidden')
            } else {
                $(inputBoxWraps[i]).addClass('hidden')
            }
        }
    })

    // 옵션 목록으로 적용 버튼 클릭시
    $("#convert-option-list-btn").on('click', function () {
        let optionWrappers = $('#option_input_wrap .input-box-wrap').not('.hidden');

        let optionNameArr = [];
        let optionValueArr = [];
        $(optionWrappers).each(function () {
            let optionName = $(this).find(".option-name-input").val();
            let optionValue = $(this).find(".option-value-input").val();

            let splitOptionValue = optionValue.split(',');
            optionNameArr.push(optionName);
            optionValueArr.push(splitOptionValue);
        });

        let combinationValues = getAllCombinations(optionValueArr);
        // 옵션명 컬럼 하나당 부여될 col width
        let colWidth = 54 / optionNameArr.length;
        // 옵션 목록 테이블 Colgroup에 들어갈 Html
        let tableHtml = '<colgroup>';
        for (let i=0; i<optionNameArr.length; i++) {
            tableHtml += '<col width="' + colWidth + '%">'
        }
        tableHtml += '<col width="23%">';
        tableHtml += '<col width="23%">';
        tableHtml += '</colgroup>';

        tableHtml += '<tr style="background-color: #ebebeb">';
        tableHtml += '  <td class="option-th" colspan="' + optionNameArr.length + '">옵션명</td>';
        tableHtml += '  <td class="option-th" rowspan="2">옵션가</td>';
        tableHtml += '  <td class="option-th" rowspan="2">재고수량</td>';
        tableHtml += '</tr>';

        tableHtml += '<tr id="option-name-tr">';
        for (let i=0; i<optionNameArr.length; i++) {
            tableHtml += '  <td style="background-color: #ebebeb; border: 1px solid #E8E8F1;" >';
            tableHtml += optionNameArr[i];
            tableHtml += '  </td>';
        }
        tableHtml += '</tr>';

        // 옵션 조합 업데이트 여부 (이 경우에는 새로 INSERT이기때문에 N으로 세팅)
        tableHtml += '<input type="hidden" id="isOptionUpdateYn" name="isOptionUpdateYn" value="N">';

        for (let i=0; i<combinationValues.length; i++) {
            tableHtml += '<tr class="option-list-tr">';
            for (let k=0; k<combinationValues[i].combination.length; k++) {
                tableHtml += '<td class="option-td">';
                tableHtml += '<input type="hidden" class="combination-index" value="' + combinationValues[i].indices[k] + '">'
                tableHtml += combinationValues[i].combination[k];
                tableHtml += '</td>';
            }
            tableHtml += '  <td class="option-td"><div class="input-box text"><input type="number" class="option-price"></div></td>';
            tableHtml += '  <td class="option-td"><div class="input-box text"><input type="number" class="option-stock"></div></td>';
            tableHtml += '</tr>'
        }

        $("#option-list-table").html(tableHtml);
    })

    // 2차원 배열 경우의 수 구하기
    function getAllCombinations(arr) {
        const result = [];
        const indices = new Array(arr.length).fill(0); // 인덱스 배열 초기화

        function generateCombinations(index) {
            if (index === arr.length) {
                const combination = arr.map((subArr, i) => subArr[indices[i]]); // 요소별 인덱스에 해당하는 값들로 조합 생성
                result.push({ combination, indices: indices.slice() });
                return;
            }

            const currentElement = arr[index];
            for (let i = 0; i < currentElement.length; i++) {
                indices[index] = i; // 인덱스 할당
                generateCombinations(index + 1);
            }
        }

        generateCombinations(0);
        return result;
    }

    function setImageFile(element){
        var reader = new FileReader();

        reader.onload = function(event){

            let img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.setAttribute("class", "col-lg-6");
            // img.setAttribute("onclick", "removeImg(this)");

            $('#images_container').append(img);
        };
        reader.readAsDataURL(event.target.files[0]);
        $('.file-div').children('.file_input').hide();

        let newFileInput = '<span class="file_input">' +
            '<label class="common-btn mini" style="background-color: #8f95e4;"> 추가' +
            '<input type="file" name="files" onchange="setImageFile(this);" style="display: none;" accept="image/jpeg, image/png, image/jpg"/>' +
            '</label></span>';

        $('.file-div').append(newFileInput);
    }

    function saveThumbnailImg(productSeq, regTypeNm){

        let fileCnt = 0;

        $('input[type=file]').each(function () {
            if ($(this).val() != '') {
                fileCnt++;
            }
        });

        if (fileCnt == 0) {
            return action_popup.alert2(regTypeNm + '되었습니다.', function() {
                location.href = '/product/management/list';
            })
        }

        $('#frm').append('<input type="hidden" name="fileForeignSeq" value="'+productSeq+'">');
        $('#frm').append('<input type="hidden" name="typeDepth1" value="product">');

        $.ajax({
            url: '/file/upload-ajax',
            type:  'POST',
            data: new FormData($('#frm')[0]),
            contentType: false,
            processData: false,
            cache:false,
            success: function (result) {
                if (result > 0) {
                    action_popup.alert2(regTypeNm + '되었습니다.', function() {
                        location.href = '/product/management/list';
                    })
                } else {
                    action_popup.alert(data.popupMsg);
                }
            }
        });
    }

    $('.xBtn').on('click', function () {
        let seq = $(this).attr('for').split('_')[1];
        $(this).parent('.thumbnail-div').remove();
        $('#frm').append('<input type="hidden" name="removeImages" value="'+seq+'">');
    });

    $('#cancelBtn').on('click', function () {
        location.href = '/product/management/list';
    });

    // 상품 등록
    $('#submitBtn').on('click', function () {
        let currProductSeq = $('#product-seq').val();
        let regType = (currProductSeq === null || currProductSeq === '' ? 'insert' : 'update');

        // 옵션 명, 옵션 값
        let optionList = [];
        $("#option_input_wrap").find(".input-box-wrap").not(".hidden").each(function (index) {
            let optionMap = {};
            let optionSeq = $(this).find(".option-seq").val();
            let optionName = $(this).find(".option-name-input").val();
            let optionValueArr = $(this).find(".option-value-input").val().split(",");
            let optionValueList = [];
            for (let i=0; i<optionValueArr.length; i++) {
                let optionValueMap = {};
                optionValueMap.name = optionValueArr[i];
                optionValueList.push(optionValueMap);
            }

            optionMap.optionSeq = optionSeq;
            optionMap.name = optionName;
            optionMap.values = optionValueList;
            optionList.push(optionMap)
        });

        // 옵션 별 가격, 재고수량
        let optionByCombinationList = [];
        let isOptionUpdateYn = $('#isOptionUpdateYn').val();
        $('.option-list-tr').each(function () {
            let combinationMap = {};
            // Insert 인 경우 조합 INDEX 정보 전송, Update인 경우 조합 Seq 전송
            if (isOptionUpdateYn === 'N') {
                let combinationIndices = [];
                $(this).find(".combination-index").each(function () {
                    combinationIndices.push($(this).val());
                });

                combinationMap.indices = combinationIndices;
            } else {
                combinationMap.option_combine_seq = $(this).find(".option_combine_seq").val();
            }
            combinationMap.price = $(this).find(".option-price").val();
            combinationMap.stock = $(this).find(".option-stock").val();
            optionByCombinationList.push(combinationMap);
        });

        console.log($('#editor').text());

        let editorContent = editor.getData();
        $("#editor").text(editorContent);
        $.ajax({
            url: "/product/management/submit-ajax/" + regType
            , type: "POST"
            , data: $("#frm").serialize() + "&optionList=" + JSON.stringify(optionList) + "&optionCombinationList=" + JSON.stringify(optionByCombinationList)
            , success: function (data) {
                if (data.name === 'pass') {
                    saveThumbnailImg(data.productSeq, regTypeNm);
                } else {
                    action_popup.alert(data.popupMsg);
                }
            }
        })
    })
</script>