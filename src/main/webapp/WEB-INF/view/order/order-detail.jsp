<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>주문 관리</title>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <script>
        $(document).ready(function() {
            let zipCode = $("#zipCode").val();
            let addr1 = $("#addr1").val();
            let addr2 = $("#addr2").val();
            let addrDetail = $("#addrDetail").val();

            if('${returnYn}' == 'Y') {
                $("#returnDiv").show();
            }

            //운송장번호 저장 버튼
            $("#saveDelivery").click(function() {
                if($("#orderDeliveryCd").val() == '' ||  $("#orderDeliveryCd").val() == null){
                    alert("택배사를 선택해주세요.");
                    return false;
                }
                if($("#orderDeliveryNo").val() == '' ||  $("#orderDeliveryNo").val() == null){
                    alert("운송장 번호를 입력해주세요.");
                    return false;
                }

                if(!confirm("저장 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/order/order-delivery-update",
                    dataType:"text",
                    data : $("#orderForm").serialize(),
                    success : function(result){
                        if(result == 'success') {
                            alert("저장이 완료되었습니다.");
                            window.location.reload();
                        } else {
                            alert("저장에 문제가 생겼습니다.");
                        }
                    }
                });
            });

            //운송장번호 수정 버튼
            $("#editDelivery").click(function() {
                $("#viewArea").hide();
                $("#editArea").show();
            });

            //운송장번호 있는 경우(배송중인경우) 수정버튼노출
            if("${order.orderDeliveryNo}" != null && "${order.orderDeliveryNo}" != ''){
                $("#viewArea").show();
                $("#editArea").hide();
            }else{
                $("#orderDeliveryNo").val('');
                $("#editArea").show();
                $("#viewArea").hide();
            }

            //배송추적 버튼
            $('#findDelivery').click ( function () {
                $('#t_code').val('${order.orderDeliveryCd}');
                $('#t_invoice').val('${order.orderDeliveryNo}');

                var windowPopup = window.open('about:blank','popupView','width=600,height=800');
                var frm = document.form;
                frm.action = 'http://info.sweettracker.co.kr/tracking/5';
                frm.target ="popupView";
                frm.method ="post";
                frm.submit();
            });

            //반품 운송장번호 저장 버튼
            $("#returnSaveDelivery").click(function() {
                if($("#returnDeliveryCd").val() == '' ||  $("#returnDeliveryCd").val() == null){
                    alert("택배사를 선택해주세요.");
                    return false;
                }
                if($("#returnDeliveryNo").val() == '' ||  $("#returnDeliveryNo").val() == null){
                    alert("운송장 번호를 입력해주세요.");
                    return false;
                }

                if(!confirm("저장 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/order/return-delivery-update",
                    dataType:"text",
                    data : $("#orderForm").serialize(),
                    success : function(result){
                        if(result == 'success') {
                            alert("저장이 완료되었습니다.");
                            window.location.reload();
                        } else {
                            alert("저장에 문제가 생겼습니다.");
                        }
                    }
                });
            });

            //반품 운송장번호 수정 버튼
            $("#returnEditDelivery").click(function() {
                $("#returnViewArea").hide();
                $("#returnEditArea").show();
            });

            //반품 운송장번호 있는 경우 수정버튼노출
            if("${order.returnDeliveryNo}" != null && "${order.returnDeliveryNo}" != ''){
                $("#returnViewArea").show();
                $("#returnEditArea").hide();
            }else{
                $("#returnDeliveryNo").val('');
                $("#returnEditArea").show();
                $("#returnViewArea").hide();
            }

            //반품 배송추적 버튼
            $('#returnFindDelivery').click ( function () {
                $('#t_code').val('${order.returnDeliveryCd}');
                $('#t_invoice').val('${order.returnDeliveryNo}');

                var windowPopup = window.open('about:blank','popupView','width=600,height=800');
                var frm = document.form;
                frm.action = 'http://info.sweettracker.co.kr/tracking/5';
                frm.target ="popupView";
                frm.method ="post";
                frm.submit();
            });

            //목록 버튼
            $("#toListBtn").click(function() {
                window.location.href = '/order/main';
            });

            //주소 변경 버튼
            $("#addrModifyBtn").click(function() {
                var guideTextBox = document.getElementById("guide");
                let toggleText = $("#addrModifyBtn").text();

                if(toggleText == '변경') {
                    $("#addrDiv1").hide();
                    $("#addrDiv2").css('display', 'inline-block');
                    $("#addrModifyBtn").text('취소');
                    $("#addrModifySubmitBtn").show();
                } else {
                    $("#zipCode").val(zipCode);
                    $("#addr1").val(addr1);
                    $("#addr2").val(addr2);
                    $("#addrDetail").val(addrDetail);

                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';

                    $("#addrDiv1").css('display', 'inline-block');
                    $("#addrDiv2").hide();
                    $("#addrModifyBtn").text('변경');
                    $("#addrModifySubmitBtn").hide();
                }
            });

            $("#addrModifySubmitBtn").click(function() {
                if(!confirm("수정 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/order/order-address-update",
                    dataType:"text",
                    data : $("#orderForm").serialize(),
                    success : function(result){
                        if(result == 'success') {
                            alert("수정이 완료되었습니다.");
                            window.location.reload();
                        } else {
                            alert("수정에 문제가 생겼습니다.");
                        }
                    }
                });
            });

        });
    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <form id="form" name="form" method="post" action="http://info.sweettracker.co.kr/tracking/5">
                <input type="hidden" id="t_key" name="t_key" value="<c:out value="${key}"/>"/>
                <input type="hidden" id="t_code" name="t_code" value="<c:out value="${order.orderDeliveryCd}"/>"/>
                <input type="hidden" id="t_invoice" name="t_invoice" value="<c:out value="${order.orderDeliveryNo}"/>"/>
            </form>
            <form id="orderForm" name="orderForm">
                <div class="home-section-wrap">
                    <section class="section home-sec">
                        <input type="hidden" id="orderSeq" name="orderSeq" value="${order.orderSeq}">
                        <!-- 주문 정보 섹션 start -->
                        <div class="common-table-top">
                            <div class="left-wrap">
                                <h3 class="table-title">주문 정보</h3>
                            </div>
                        </div>
                        <table class="common-table" summary="주문상세정보">
                            <colgroup>
                                <col width="10%">
                                <col width="40%">
                                <col width="10%">
                                <col width="40%">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">주문 번호</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.orderNo}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">주문 상태</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.orderStatus}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">주문자명</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.memberNm}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">주문자 전화번호</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.memberPhoneFull}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">주문자 아이디</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.memberId}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">주문 일시</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.regDt}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">수령인</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.orderToName}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">수령인 전화번호</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.orderToPhoneFull}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">운송장번호</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <span id="viewArea" style="display: none;">
                                            <div style="display: inline-block">
                                                <c:if test="${order.orderDeliveryCd eq '04'}">CJ대한통운</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '08'}">롯데택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '05'}">한진택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '01'}">우체국택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '23'}">경동택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '06'}">로젠택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '56'}">KGB택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '11'}">일양택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '22'}">대신택배</c:if>
                                                <c:if test="${order.orderDeliveryCd eq '00'}">기타</c:if>
                                                &nbsp;
                                                ${order.orderDeliveryNo}
                                                &nbsp;
                                                <c:if test="${order.orderStatus ne '배송완료' && order.orderStatus ne '반품완료' && order.orderStatus ne '반품처리'}">
                                                    <!-- 배송완료 또는 반품 상태일 경우 수정 불가 -->
                                                    <button class="common-btn" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" type="button" id="editDelivery"><span>수정</span></button>
                                                </c:if>
                                                <button class="common-btn" style="padding: 8px 10px; font-size: 15px; min-width: 60px; margin-left: 10px;" type="button" id="findDelivery"><span>배송 추적</span></button>
                                            </div>
                                        </span>
                                        <span id="editArea" style="display: none;">
                                            <div class="common-sel-sch-wrap">
                                                <div class="basic-select-box">
                                                    <select id="orderDeliveryCd" name="orderDeliveryCd">
                                                        <option value="">택배사 선택</option>
                                                        <option value="04" <c:if test="${order.orderDeliveryCd eq '04'}">selected</c:if> >CJ대한통운</option>
                                                        <option value="08" <c:if test="${order.orderDeliveryCd eq '08'}">selected</c:if> >롯데택배</option>
                                                        <option value="05" <c:if test="${order.orderDeliveryCd eq '05'}">selected</c:if> >한진택배</option>
                                                        <option value="01" <c:if test="${order.orderDeliveryCd eq '01'}">selected</c:if> >우체국택배</option>
                                                        <option value="23" <c:if test="${order.orderDeliveryCd eq '23'}">selected</c:if> >경동택배</option>
                                                        <option value="06" <c:if test="${order.orderDeliveryCd eq '06'}">selected</c:if> >로젠택배</option>
                                                        <option value="56" <c:if test="${order.orderDeliveryCd eq '56'}">selected</c:if> >KGB택배</option>
                                                        <option value="11" <c:if test="${order.orderDeliveryCd eq '11'}">selected</c:if> >일양택배</option>
                                                        <option value="22" <c:if test="${order.orderDeliveryCd eq '22'}">selected</c:if> >대신택배</option>
                                                        <option value="00" <c:if test="${order.orderDeliveryCd eq '00'}">selected</c:if> >기타</option>
                                                    </select>
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                <div class="common-sch-box">
                                                    <div class="input-box text" style="width: auto; display: inline-block;">
                                                        <input type="text" class="common-search" title="운송장번호" placeholder="운송장 번호를 입력하세요." id="orderDeliveryNo" name="orderDeliveryNo" value="${order.orderDeliveryNo}"/>
                                                        <span class="border-focus"><i></i></span>
                                                    </div>
                                                    <button class="common-btn" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" type="button" id="saveDelivery"><span>저장</span></button>
                                                </div>
                                            </div>
                                        </span>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">배송 요청사항</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${order.orderDeliveryComment}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">수령인 주소</div></th>
                                <td class="cell-td dt-left" colspan="4">
                                    <div class="con-td">
                                        <div id="addrDiv1" style="display: inline-block;">
                                            <span>${order.orderToAddrFull}</span>
                                        </div>
                                        <div id="addrDiv2" style="display: none;">
                                            <div class="input-box text">
                                                <input style="width: auto;" type="text" id="zipCode" name="orderToZipCode" placeholder="우편번호" value="${order.orderToZipCode}" readonly>
                                                <input style="width: auto;" type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
                                                <span id="guide" style="color:#999;display:none"></span>
                                                <br>
                                                <input style="width: 313px;" type="text" id="addr1" name="orderToAddr1" placeholder="도로명주소" value="${order.orderToAddr1}" readonly>
                                                <input style="width: auto;" type="text" id="addr2" name="orderToAddr2" placeholder="참고항목" value="${order.orderToAddr2}" readonly>
                                                <input style="width: auto;" type="text" id="addrDetail" name="orderToAddrDetail" placeholder="상세주소" value="${order.orderToAddrDetail}">
                                            </div>
                                        </div>
                                        <c:if test="${order.orderStatus eq '상품준비중' || order.orderStatus eq '배송준비중'}">
                                            <!-- 상품준비중 또는 배송준비중 상태가 아닐 경우 수정 불가 -->
                                            <button type="button" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" class="common-btn" aria-label="title" id="addrModifyBtn"><span>변경</span></button>
                                            <button type="button" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px; display: none;" class="common-btn" aria-label="title" id="addrModifySubmitBtn"><span>변경</span></button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- 주문 정보 섹션 end -->

                        <!-- 반품 운송장 섹션 start -->
                        <div id="returnDiv" style="display: none; margin-top: 50px;">
                            <div class="common-table-top">
                                <div class="left-wrap">
                                    <h3 class="table-title">반품 배송 정보</h3>
                                </div>
                            </div>
                            <table class="common-table" summary="반품운송장정보">
                                <colgroup>
                                    <col width="10%">
                                    <col width="40%">
                                    <col width="10%">
                                    <col width="40%">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th class="row-th" scope="row"><div class="con-th">반품 운송장번호</div></th>
                                    <td class="cell-td dt-left" colspan="4">
                                        <div class="con-td">
                                            <span id="returnViewArea" style="display: none;">
                                                <div style="display: inline-block">
                                                    <c:if test="${order.returnDeliveryCd eq '04'}">CJ대한통운</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '08'}">롯데택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '05'}">한진택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '01'}">우체국택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '23'}">경동택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '06'}">로젠택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '56'}">KGB택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '11'}">일양택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '22'}">대신택배</c:if>
                                                    <c:if test="${order.returnDeliveryCd eq '00'}">기타</c:if>
                                                    &nbsp;
                                                    ${order.returnDeliveryNo}
                                                    &nbsp;
                                                    <c:if test="${order.orderStatus ne '반품완료'}">
                                                        <!-- 반품완료 상태일 경우 수정 불가 -->
                                                        <button class="common-btn" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" type="button" id="returnEditDelivery"><span>수정</span></button>
                                                    </c:if>
                                                    <button class="common-btn" style="padding: 8px 10px; font-size: 15px; min-width: 60px; margin-left: 10px;" type="button" id="returnFindDelivery"><span>배송 추적</span></button>
                                                </div>
                                            </span>
                                            <span id="returnEditArea" style="display: none;">
                                                <div class="common-sel-sch-wrap">
                                                    <div class="basic-select-box">
                                                        <select id="returnDeliveryCd" name="returnDeliveryCd">
                                                            <option value="">택배사 선택</option>
                                                            <option value="04" <c:if test="${order.returnDeliveryCd eq '04'}">selected</c:if> >CJ대한통운</option>
                                                            <option value="08" <c:if test="${order.returnDeliveryCd eq '08'}">selected</c:if> >롯데택배</option>
                                                            <option value="05" <c:if test="${order.returnDeliveryCd eq '05'}">selected</c:if> >한진택배</option>
                                                            <option value="01" <c:if test="${order.returnDeliveryCd eq '01'}">selected</c:if> >우체국택배</option>
                                                            <option value="23" <c:if test="${order.returnDeliveryCd eq '23'}">selected</c:if> >경동택배</option>
                                                            <option value="06" <c:if test="${order.returnDeliveryCd eq '06'}">selected</c:if> >로젠택배</option>
                                                            <option value="56" <c:if test="${order.returnDeliveryCd eq '56'}">selected</c:if> >KGB택배</option>
                                                            <option value="11" <c:if test="${order.returnDeliveryCd eq '11'}">selected</c:if> >일양택배</option>
                                                            <option value="22" <c:if test="${order.returnDeliveryCd eq '22'}">selected</c:if> >대신택배</option>
                                                            <option value="00" <c:if test="${order.returnDeliveryCd eq '00'}">selected</c:if> >기타</option>
                                                        </select>
                                                        <span class="border-focus"><i></i></span>
                                                    </div>
                                                    <div class="common-sch-box">
                                                        <div class="input-box text" style="width: auto; display: inline-block;">
                                                            <input type="text" class="common-search" title="운송장번호" placeholder="운송장 번호를 입력하세요." id="returnDeliveryNo" name="returnDeliveryNo" value="${order.returnDeliveryNo}"/>
                                                            <span class="border-focus"><i></i></span>
                                                        </div>
                                                        <button class="common-btn" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" type="button" id="returnSaveDelivery"><span>저장</span></button>
                                                    </div>
                                                </div>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- 반품 운송장 섹션 end -->

                        <!-- 상품 정보 섹션 start -->
                        <div class="common-table-top" style="margin-top: 50px;">
                            <div class="left-wrap">
                                <h3 class="table-title">상품 정보</h3>
                            </div>
                        </div>
                        <table class="common-table" summary="상품상세정보">
                            <colgroup>
                                <col width="10%">
                                <col width="40%">
                                <col width="10%">
                                <col width="40%">
                            </colgroup>
                            <tbody>
                            <c:forEach var="product" items="${order.productList}" varStatus="status">
                                <tr>
                                    <th class="row-th" scope="row" rowspan="2"><div class="con-th">상품</div></th>
<%--                                    <th rowspan="2" scope="row" style="padding : 12px 15px !important; <c:if test="${fn:length(order.productList) eq status.count}">border-bottom-left-radius : 6px;</c:if>"><em>상품</em></th>--%>
                                    <td class="cell-td dt-left" rowspan="2">
                                        <div class="con-td">
                                            ${product.product_name}
                                            <c:if test="${product.order_option ne ''}">
                                                <br>
                                                옵션 - ${product.order_option}
                                            </c:if>
                                        </div>
                                    </td>
                                    <th class="row-th" scope="row"><div class="con-th">수량</div></th>
                                    <td class="cell-td dt-left">
                                        <div class="con-td">
                                            ${product.order_product_stock}개
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="row-th" scope="row"><div class="con-th">금액</div></th>
                                    <td class="cell-td dt-left">
                                        <div class="con-td">
                                            <fmt:formatNumber value="${product.product_price * product.order_product_stock}" pattern="#,###"/> 원
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <!-- 상품 정보 섹션 end -->

                        <div style="margin-top: 20px; float: right;">
                            <button type="button" id="toListBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>목록</span></button>
                        </div>
                    </section>
                </div>
            </form>
        </div>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
