<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>주문 관리</title>
</head>
<body>
    <script>

        // datepicker init
        $(function () {
            initPrivacyDatePicker($("#startReg"), $("#endReg"));
        });

        // 주문 리스트 조회
        function getOrderList(page) {
            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let orderStatusList = [];

            $("input:checkbox[name='statusSelect']").each(function() {
               if($(this).is(":checked") == true) {
                   orderStatusList.push($(this).attr("id").split("_")[1]);
               }
            });

            let params = {
                'curPage' : (page) ? page : '1',
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword,
                'orderStatusList' : orderStatusList
            };

            $.ajax({
                type : "POST",
                url : "/order/select-order-list",
                dataType:"html",
                contentType : 'application/json; charset=utf-8',
                data : JSON.stringify(params),
                success : function(data){
                    // 초기화
                    $("#dataTableDiv").empty();

                    $("#dataTableDiv").html(data);
                }
            });
        }

        // 운송장 일괄 등록 팝업
        $(document).on("click", "#excelDeliveryNoUpload", function() {
            PopupReg1("insert-delivery-list-popup", 650, 400, "popup");
        });

        // 주문 정보 상세 페이지
        $(document).on("click", ".orderData", function() {
            let oseq = $(this).data("oseq");
            window.location.href = "/order/order-detail?orderSeq=" + oseq;

            // let opseq = $(this).data("opseq");
            // window.location.href = "/order/order-detail?orderSeq=" + oseq + "&orderProductSeq=" + opseq;
        });

        // 주문 정보 엑셀 다운로드
        $(document).on("click", "#excelOrderDownload", function() {
            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let sDate = new Date(startDate);
            let nowDate = new Date();

            let orderSeqList = [];
            let orderStatusList = [];

            nowDate.setMonth(nowDate.getMonth() - 3);
            if(sDate < nowDate) {
                alert("주문 기간이 3개월 경과된 내역은 다운로드 할 수 없습니다.");
                return false;
            }

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   orderSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            $("input:checkbox[name='statusSelect']").each(function() {
               if($(this).is(":checked") == true) {
                   orderStatusList.push($(this).attr("id").split("_")[1]);
               }
            });

            let params = {
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword,
                'orderSeqList' : orderSeqList,
                'orderStatusList' : orderStatusList
            };

            $("#dataJson").val(JSON.stringify(params));
            $('#frmDefault').attr ('action', '/order/excel/download-order-excel').submit();
        });

        // 주문 상태 변경 버튼
        $(document).on("click", "button[name='orderStatusBtn']", function() {
            let btnText = $(this).text();
            let orderStatus = $(this).data("status");

            let orderSeqList = [];

            if(!confirm(btnText + " 하시겠습니까?")) {
                return false;
            }

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   orderSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            if(orderSeqList.length <= 0) {
                alert('선택된 데이터가 없습니다.');
                return false;
            }

            let params = {
                'orderStatus' : orderStatus,
                'orderSeqList' : orderSeqList
            };

            $.ajax({
                    type : "POST",
                    url : "/order/order-status-update",
                    dataType:"text",
                    contentType : 'application/json; charset=utf-8',
                    data : JSON.stringify(params),
                    success : function(result){
                        if(result == 'success') {
                            alert(btnText + "가 완료되었습니다.");
                            window.location.reload();
                        } else if(result == '404') {
                            alert(btnText + "에 문제가 생겼습니다.");
                        } else {
                            alert(result);
                        }
                    }
                });
        });

        $(document).ready(function() {
            //검색 버튼
            $("#searchBtn").click(function() {
                getOrderList(1);
            });

            $("#searchKeyword").on("keyup",function(key){
                if(key.keyCode==13) {
                    getOrderList(1);
                }
            });

            //주문 상태 체크박스
            $("input[name='orderStatusSelectAll'], input[name='statusSelect']").change(function() {
                getOrderList(1);
            });

            getOrderList();
        });

    </script>

    <style>
        .order-status-chk {
            display:inline-block;
            margin-right:5px;
        }
    </style>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <div class="home-section-wrap">
                <div>
                    <h2 class="sec-title">주문 관리</h2>
                    <p class="txt">주문 리스트 조회</p>
                </div>
            </div>
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <form id="frmDefault" name="default" action="" method="post">
                        <input type="hidden" id="dataJson" name="dataJson" value="">
                        <table class="common-table" summary="검색" style="width:100%;">
                            <tbody>
                            <tr>
                                <th scope="row"><em>등록일</em></th>
                                <td style="border-top: 1px solid #c6c9cc; cursor: default;">
                                    <div class="field">
                                        <div class="datepicker-box-wrap" style="display: inline-block">
                                            <div class="input-box datepicker-box">
                                                <input type="text" class="" name="startDate" id="startReg" title="등록일자 시작일 입력" value="" autocomplete='off'>
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                        ~
                                        <div class="datepicker-box-wrap" style="display: inline-block">
                                            <div class="input-box datepicker-box">
                                                <input type="text" class="" name="endDate" id="endReg" title="등록일자 만료일 입력" value="" autocomplete='off'>
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><em>검색어</em></th>
                                <td style="cursor: default;">
                                    <div class="basic-select-box" style="width: 10%; display: inline-block;">
                                        <select id="searchType" name="searchType" style="">
                                            <option value="orderNo">주문번호</option>
    <%--                                        <option value="productName">상품명</option>--%>
                                            <option value="memberId">아이디</option>
                                            <option value="memberNm">이름</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                    <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요." style="height: 34px;" value="${searchKeyword}">
                                    <span class="border-focus"><i></i></span>
                                    <button type="button" class="search-btn" id="searchBtn">
                                        <img src="../../asset/img/admin/icon-search.svg" alt="검색하기">
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><em>주문 상태</em></th>
                                <td style="cursor: default;">
                                    <div>
                                        <div class="basic-check-box all-check-box order-status-chk">
                                            <input type="checkbox" name="orderStatusSelectAll" id="orderStatusSelectAll" tabindex="-1">
                                            <label for="orderStatusSelectAll" tabindex="0">전체</label>
                                        </div>
                                        <ul class="chkgroup-list" style="display:inline-block;">
                                            <c:forEach var="map" items="${statusMap}">
                                                <li class="order-status-chk">
                                                    <div class="basic-check-box">
                                                        <input type="checkbox" name="statusSelect" id="chk_${map.key}" tabindex="-1" class="orderchkgroup">
                                                        <label for="chk_${map.key}" tabindex="0">${map.value}</label>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </section>
            </div>
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <div id="dataTableDiv">
                    </div>
                </section>
            </div>
        </div>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>