<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<script src="lodash.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.11/lodash.min.js"></script>
<main id="main" class="page-home">
    <div class="admin-section-wrap">
        <form id="frm" name="frm">
            <input type="hidden" id="coupon-seq" name="coupon_seq" value="${couponDetailInfo.coupon_seq}"/>
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <table class="common-table" summary="쿠폰상세정보">
                        <colgroup>
                            <col width="15%">
                            <col width="85%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">쿠폰명</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box-wrap">
                                            <div class="input-box text">
                                                <input type="text" id="coupon-name" name="coupon_name" value="${couponDetailInfo.coupon_name}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">쿠폰 설명</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box-wrap">
                                            <div class="input-box text">
                                                <input type="text" id="coupon-description" name="coupon_description" value="${couponDetailInfo.coupon_description}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">혜택 구분</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="amount" name="coupon_benefit_type" value="amount" <c:if test="${couponDetailInfo.coupon_benefit_type == 'amount' or regType == 'insert'}">checked</c:if> >
                                                <label for="amount"><span>할인 금액</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="percentage" name="coupon_benefit_type" value="percentage" <c:if test="${couponDetailInfo.coupon_benefit_type == 'percentage'}">checked</c:if>>
                                                <label for="percentage"><span>할인율</span></label>
                                            </div>
                                            <div id="coupon-benefit-amount-wrap" <c:if test="${couponDetailInfo.coupon_benefit_type != 'amount' and regType != 'insert'}">class="hidden"</c:if> >
                                                <hr/>
                                                <span>할인금액 : </span>
                                                <div class="input-box text" style="width: 20%; display: inline-block;">
                                                    <input type="text" id="coupon_benefit_amount" name="coupon_benefit_amount" <c:if test="${couponDetailInfo.coupon_benefit_type == 'amount'}">value="${couponDetailInfo.coupon_benefit_amount}"</c:if> >
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                원
                                            </div>
                                            <div id="coupon-benefit-percentage-wrap" <c:if test="${couponDetailInfo.coupon_benefit_type != 'percentage'}">class="hidden"</c:if> >
                                                <hr/>
                                                <span>할인율 : </span>
                                                <div class="input-box text" style="width: 20%; display: inline-block;">
                                                    <input type="text" id="coupon_benefit_percentage" name="coupon_benefit_percentage" <c:if test="${couponDetailInfo.coupon_benefit_type == 'percentage'}">value="${couponDetailInfo.coupon_benefit_percentage}"</c:if> >
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                %
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">발급 구분</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="download" name="coupon_issue_type" value="download" <c:if test="${couponDetailInfo.coupon_issue_type == 'download' or regType == 'insert'}">checked</c:if>>
                                                <label for="download"><span>다운로드시 발급</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="conditional" name="coupon_issue_type" value="conditional" <c:if test="${couponDetailInfo.coupon_issue_type == 'conditional'}">checked</c:if> >
                                                <label for="conditional"><span>조건부 발급</span></label>
                                            </div>
                                            <div id="coupon-issue-type-wrap" <c:if test="${couponDetailInfo.coupon_issue_type != 'conditional' or regType == 'insert'}">class="hidden"</c:if> >
                                                <hr/>
                                                <div class="basic-select-box" style="width: 20%; display: inline-block">
                                                    <select name="coupon_issue_condition_type">
                                                        <option value="join" <c:if test="${couponDetailInfo.coupon_issue_condition_type == 'join'}">selected</c:if>>회원가입</option>
                                                        <option value="order" <c:if test="${couponDetailInfo.coupon_issue_condition_type == 'order'}">selected</c:if>>주문</option>
                                                        <option value="birthday" <c:if test="${couponDetailInfo.coupon_issue_condition_type == 'birthday'}">selected</c:if>>생일 도래</option>
                                                    </select>
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                <span>시 발급</span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">쿠폰 적용범위</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="product" name="coupon_coverage_type" value="product" <c:if test="${couponDetailInfo.coupon_coverage_type == 'product' or regType == 'insert'}">checked</c:if> >
                                                <label for="product"><span>상품</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="order" name="coupon_coverage_type" value="order" <c:if test="${couponDetailInfo.coupon_coverage_type == 'order'}">checked</c:if>>
                                                <label for="order"><span>주문서</span></label>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">동일쿠폰 발급 제한</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="is-not-coupon-issue-per-limit" name="is_coupon_issue_per_limit" value="false" <c:if test="${couponDetailInfo.is_coupon_issue_per_limit == false or regType == 'insert'}">checked</c:if> >
                                                <label for="is-not-coupon-issue-per-limit"><span>제한 없음</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="is-coupon-issue-per-limit" name="is_coupon_issue_per_limit" value="true" <c:if test="${couponDetailInfo.is_coupon_issue_per_limit == true}">checked</c:if>>
                                                <label for="is-coupon-issue-per-limit"><span>제한</span></label>
                                            </div>
                                        </div>
                                        <div id="coupon-issue-per-limit-wrap" <c:if test="${couponDetailInfo.is_coupon_issue_per_limit == false or regType == 'insert'}">class="hidden"</c:if> >
                                            <hr/>
                                            <span>1인당 최대 발급수량 : </span>
                                            <div class="input-box text" style="width: 10%; display: inline-block;">
                                                <input type="text" id="coupon-issue-per-limit" name="coupon_issue_per_limit" <c:if test="${couponDetailInfo.is_coupon_issue_per_limit == true}">value="${couponDetailInfo.coupon_issue_per_limit}"</c:if> >
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            매
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">총 발급 쿠폰수</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="is-not-coupon-issue-limit" name="is_coupon_issue_limit" value="false" <c:if test="${couponDetailInfo.is_coupon_issue_limit == false or regType == 'insert'}">checked</c:if> >
                                                <label for="is-not-coupon-issue-limit"><span>제한 없음</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="is-coupon-issue-limit" name="is_coupon_issue_limit" value="true" <c:if test="${couponDetailInfo.is_coupon_issue_limit == true}">checked</c:if>>
                                                <label for="is-coupon-issue-limit"><span>제한</span></label>
                                            </div>
                                        </div>
                                        <div id="coupon-issue-limit-wrap" <c:if test="${couponDetailInfo.is_coupon_issue_limit == false or regType == 'insert'}">class="hidden"</c:if> >
                                            <hr/>
                                            <span>총 발급수량 : </span>
                                            <div class="input-box text" style="width: 10%; display: inline-block;">
                                                <input type="text" id="coupon-issue-limit" name="coupon_issue_limit" <c:if test="${couponDetailInfo.is_coupon_issue_limit == true}">value="${couponDetailInfo.coupon_issue_limit}"</c:if> >
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            매
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">쿠폰 발급기간</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="field">
                                            <div class="datepicker-box-wrap" style="display: inline-block">
                                                <div class="input-box datepicker-box">
                                                    <input type="text" class="" name="coupon_issue_start_date" id="coupon-issue-start-date" title="발급 시작일 입력" value="${couponDetailInfo.coupon_issue_start_date}" autocomplete='off'>
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                            </div>
                                            ~
                                            <div class="datepicker-box-wrap" style="display: inline-block">
                                                <div class="input-box datepicker-box">
                                                    <input type="text" class="" name="coupon_issue_end_date" id="coupon-issue-end-date" title="발급 종료일 입력" value="${couponDetailInfo.coupon_issue_end_date}" autocomplete='off'>
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">쿠폰 사용기간</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="field">
                                            <div class="datepicker-box-wrap" style="display: inline-block">
                                                <div class="input-box datepicker-box">
                                                    <input type="text" class="" name="coupon_use_start_date" id="coupon-use-start-date" title="발급 시작일 입력" value="${couponDetailInfo.coupon_use_start_date}" autocomplete='off'>
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                            </div>
                                            ~
                                            <div class="datepicker-box-wrap" style="display: inline-block">
                                                <div class="input-box datepicker-box">
                                                    <input type="text" class="" name="coupon_use_end_date" id="coupon-use-end-date" title="발급 종료일 입력" value="${couponDetailInfo.coupon_use_end_date}" autocomplete='off'>
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                            </div>
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
    $(function () {
        initDatePicker($("#coupon-use-start-date"), $("#coupon-use-end-date"));
        initDatePicker($("#coupon-issue-start-date"), $("#coupon-issue-end-date"));
    });

    // 혜택 구분
    $("input[name='coupon_benefit_type']").on('change', function () {
        let value = $(this).val();
        if (value === 'amount') {
            $("#coupon-benefit-amount-wrap").removeClass('hidden');
            $("#coupon-benefit-percentage-wrap").addClass('hidden');
        } else {
            $("#coupon-benefit-amount-wrap").addClass('hidden');
            $("#coupon-benefit-percentage-wrap").removeClass('hidden');
        }
    });

    // 발급 구분
    $("input[name='coupon_issue_type']").on('change', function () {
        let value = $(this).val();
        if (value === 'conditional') {
            $("#coupon-issue-type-wrap").removeClass('hidden');
        } else {
            $("#coupon-issue-type-wrap").addClass('hidden');
        }
    });

    // 동일쿠폰 발급 제한
    $("input[name='is_coupon_issue_per_limit']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $("#coupon-issue-per-limit-wrap").removeClass('hidden');
        } else {
            $("#coupon-issue-per-limit-wrap").addClass('hidden');
        }
    });

    // 쿠폰 발급 수 제한
    $("input[name='is_coupon_issue_limit']").on('change', function () {
        let value = $(this).val();
        if (value === 'true') {
            $("#coupon-issue-limit-wrap").removeClass('hidden');
        } else {
            $("#coupon-issue-limit-wrap").addClass('hidden');
        }
    });

    $('#cancelBtn').on('click', function () {
        location.href = '/promotion/coupon/list';
    });

    $('#submitBtn').on('click', function () {
        let currCouponSeq = $('#coupon-seq').val();
        let regType = (currCouponSeq === null || currCouponSeq === '' ? 'insert' : 'update');
        let regTypeNm = regType === 'insert' ? '등록' : '수정';

        $.ajax({
            url: "/promotion/coupon/submit-ajax/" + regType
            , type: "POST"
            , data: $("#frm").serialize()
            , success: function (data) {
                if (data.name === 'pass') {
                    action_popup.alert2(regTypeNm + ' 되었습니다.', function () {
                        location.href = '/promotion/coupon/list';
                    })
                } else {
                    action_popup.alert(data.popupMsg);
                }
            }
        })
    })
</script>