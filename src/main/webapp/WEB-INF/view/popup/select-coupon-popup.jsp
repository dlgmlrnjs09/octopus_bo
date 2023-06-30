<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
    <head>
        <title>상품주문쿠폰</title>
    </head>
    <body>
        <table class="common-table" summary="상품주문쿠폰" style="padding: 20px;">
            <colgroup>
                <col width="8%">
            </colgroup>
           <tr>
               <th class="row-th" scope="row"><div class="con-th">선택</div></th>
               <th class="row-th" scope="row"><div class="con-th">쿠폰명</div></th>
               <th class="row-th" scope="row"><div class="con-th">혜택</div></th>
               <th class="row-th" scope="row"><div class="con-th">발급기간</div></th>
               <th class="row-th" scope="row"><div class="con-th">사용기간</div></th>
            </tr>
            <c:forEach items="${orderCouponList}" var="couponList">
                <tr>
                    <td class="cell-td dt-left">
                        <div class="con-td">
                            <div class="radio-box-wrap">
                                <div class="basic-radio-box">
                                        <input id="coupon-seq-${couponList.coupon_seq}" type="radio" name="coupon_seq" value="${couponList.coupon_seq}">
                                    <label for="coupon-seq-${couponList.coupon_seq}">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="cell-td dt-left">
                        <div class="con-td">
                            ${couponList.coupon_name}
                        </div>
                    </td>
                    <td class="cell-td dt-left">
                        <div class="con-td">
                            ${couponList.coupon_issue_condition_type_nm}시
                            <c:if test="${couponList.coupon_benefit_type == 'amount'}">
                                ${couponList.coupon_benefit_amount}원
                            </c:if>
                            <c:if test="${couponList.coupon_benefit_type == 'percentage'}">
                                ${couponList.coupon_benefit_percentage}%
                            </c:if>
                            할인
                        </div>
                    </td>
                    <td class="cell-td dt-left">
                        <div class="con-td">
                            ${couponList.coupon_issue_start_date} ~ ${couponList.coupon_issue_end_date}
                        </div>
                    </td>
                    <td class="cell-td dt-left">
                        <div class="con-td">
                            ${couponList.coupon_use_start_date} ~ ${couponList.coupon_use_end_date}
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <div style="margin-top: 20px; text-align: center;">
            <button type="button" id="cancelBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title" onclick="selectComplete()"><span>선택</span></button>
            <button type="button" id="submitBtn" style="padding: 10px; font-size: 15px;" class="common-btn" aria-label="title" onclick="window.close()"><span>취소</span></button>
        </div>
    </body>

    <script>
        function selectComplete() {
            let selectedCouponSeq = $('input[name="coupon_seq"]:checked').val();
            alert(selectedCouponSeq);
            $(opener.document).find('#product-order-coupon-seq').val(selectedCouponSeq);
            window.close();
        }
    </script>
</html>
