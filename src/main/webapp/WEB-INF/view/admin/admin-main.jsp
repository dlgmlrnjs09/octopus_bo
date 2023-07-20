<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>관리자 관리</title>
</head>
<body>
    <script>
        // datepicker init
        $(function () {
            initPrivacyDatePicker($("#startDate"), $("#endDate"));
        });

        // 괸리자 리스트 조회
        function getAdminList(page) {
            const pageParam = Number(new URLSearchParams(location.search).get('curPage'));
            page = (page) ? page : ((pageParam) ? pageParam : 1);

            const form = document.getElementById('frmDefault');
            let params = {
                'curPage' : page,
                'startDate' : form.startDate.value,
                'endDate' : form.endDate.value,
                'searchType' : form.searchType.value,
                'searchKeyword' : form.searchKeyword.value,
            };

            // 쿼리스트링을 포함한 URI 세팅
            const queryString = new URLSearchParams(params).toString();
            const replaceUri = location.pathname + '?' + queryString;
            history.replaceState({}, '', replaceUri);

            $.ajax({
                type : "GET",
                url : "/admin/select-admin-list",
                dataType:"html",
                data : params,
                success : function(data){
                    // 초기화
                    $("#dataTableDiv").empty();

                    $("#dataTableDiv").html(data);
                }
            });
        }

        // 회원 정보 상세 페이지
        $(document).on("click", ".adminData", function() {
            const queryString = new URLSearchParams(location.search).toString();

            let seq = $(this).data("seq");
            window.location.href = "/admin/admin-detail?adminSeq=" + seq + "&" + queryString;
        });

        // 회원 정보 엑셀 다운로드
        $(document).on("click", "#excelAdminDownload", function() {
            let adminSeqList = [];

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   adminSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            const form = document.getElementById('frmDefault');
            let params = {
                'startDate' : form.startDate.value,
                'endDate' : form.endDate.value,
                'searchType' : form.searchType.value,
                'searchKeyword' : form.searchKeyword.value,
                'adminSeqList' : adminSeqList
            };

            $("#dataJson").val(JSON.stringify(params));
            $('#frmDefault').attr ('action', '/admin/excel/download-admin-excel').submit();
        });

        // 회원 일괄 등록 팝업
        $(document).on("click", "#excelAdminUpload", function() {
            PopupReg1("insert-admin-list-popup", 650, 400, "popup");
        });

        $(document).ready(function() {
            //검색 버튼
            $("#searchBtn").click(function() {
                getAdminList(1);
            });

            $("#searchKeyword").on("keyup",function(key){
                if(key.keyCode==13) {
                    getAdminList(1);
                }
            });

            // 쿼리스트링 해당 form에 매핑
            setQueryStringParams('frmDefault');
            getAdminList();
        });

    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <form id="frmDefault" name="default" action="" method="post">
                        <input type="hidden" id="dataJson" name="dataJson" value="">
                        <table class="common-table" summary="검색" style="width:100%;">
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
                                            <select id="searchType" name="searchType" style="">
                                                <option value="adminId">아이디</option>
                                                <option value="adminName">이름</option>
                                                <option value="adminEmail">이메일</option>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <div class="common-sch-box" style="width: 314px;">
                                            <div class="input-box text">
                                                <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요." style="height: 34px;">
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
