<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>리뷰 관리</title>
</head>
<body>
    <script>
        // datepicker init
        $(function () {
            initDatePicker($("#startDate"), $("#endDate"));
        });

        // 리뷰 리스트 조회
        function getReviewList(page) {
            let pageSize = $("#pageSize").val();
            const pageParam = Number(new URLSearchParams(location.search).get('curPage'));
            const pageSizeParam = Number(new URLSearchParams(location.search).get('pageSize'));
            page = (page) ? page : ((pageParam) ? pageParam : 1);
            pageSize = (pageSize) ? pageSize: ((pageSizeParam) ? pageSizeParam : 10);

            const form = document.getElementById('frmDefault');
            let params = {
                'curPage' : page,
                'pageSize' : pageSize,
                'startDate' : form.startDate.value,
                'endDate' : form.endDate.value,
                'searchType' : form.searchType.value,
                'searchKeyword' : form.searchKeyword.value
            };

            // 쿼리스트링을 포함한 URI 세팅
            const queryString = new URLSearchParams(params).toString();
            const replaceUri = location.pathname + '?' + queryString;
            history.replaceState({}, '', replaceUri);

            $.ajax({
                type : "POST",
                url : "/product/review/select-review-list",
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

        // 리뷰 상세 페이지
        $(document).on("click", ".reviewData", function() {
            const queryString = new URLSearchParams(location.search).toString();

            let seq = $(this).data("seq");
            window.location.href = "/product/review/review-detail?reviewSeq=" + seq + "&" + queryString;
        });

        // 리뷰 정보 엑셀 다운로드
        $(document).on("click", "#excelReviewDownload", function() {
            let reviewSeqList = [];

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   reviewSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            const form = document.getElementById('frmDefault');
            let params = {
                'startDate' : form.startDate.value,
                'endDate' : form.endDate.value,
                'searchType' : form.searchType.value,
                'searchKeyword' : form.searchKeyword.value,
                'reviewSeqList' : reviewSeqList
            };

            $("#dataJson").val(JSON.stringify(params));
            $('#frmDefault').attr ('action', '/product/review/excel/download-review-excel').submit();
        });

        $(document).ready(function() {
            //검색 버튼
            $("#searchBtn").click(function() {
                getReviewList(1);
            });

            $("#searchKeyword").on("keyup",function(key){
                if(key.keyCode==13) {
                    getReviewList(1);
                }
            });

            // 쿼리스트링 해당 form에 매핑
            setQueryStringParams('frmDefault');
            getReviewList();
        });
    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <form id="frmDefault" name="default" action="" method="post">
                        <input type="hidden" id="dataJson" name="dataJson" value="">
                        <input type="hidden" name="orderStatusList" id="orderStatusList" value="">
                        <table class="common-table" summary="검색">
                            <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등록일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="datepicker-box-wrap" style="display: inline-block">
                                            <div class="input-box datepicker-box">
                                                <input type="text" class="" name="startDate" id="startDate" title="등록일자 시작일 입력" value="" autocomplete='off'>
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                        ~
                                        <div class="datepicker-box-wrap" style="display: inline-block">
                                            <div class="input-box datepicker-box">
                                                <input type="text" class="" name="endDate" id="endDate" title="등록일자 만료일 입력" value="" autocomplete='off'>
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">검색어</div></th>
                                <td class="cell-td dt-left">
                                    <div class="common-sel-sch-wrap">
                                        <div class="basic-select-box">
                                            <select id="searchType" name="searchType">
                                                <option value="productName">상품명</option>
                                                <option value="regId">아이디</option>
                                                <option value="memberNm">이름</option>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <div class="common-sch-box" style="width: 314px;">
                                            <div class="input-box text">
                                                <input class="common-search" type="text" id="searchKeyword" placeholder="검색어를 입력하세요.">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            <button title="검색하기" type="button" class="search-btn" id="searchBtn" tabindex="0"><img src="../../asset/img/icon-search.svg" alt="검색하기"></button>
                                        </div>
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