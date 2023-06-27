<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 관리</title>
</head>
<body>
    <script>

        // datepicker init
        $(function () {
            initPrivacyDatePicker($("#startReg"), $("#endReg"));
        });

        // 회원 리스트 조회
        function getUserList(page) {
            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let params = {
                'curPage' : (page) ? page : '1',
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword
            };

            $.ajax({
                type : "GET",
                url : "/member/select-member-list",
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
        $(document).on("click", ".memberData", function() {
            let seq = $(this).data("seq");
            window.location.href = "/member/member-detail?memberSeq=" + seq;
        });

        // 회원 정보 엑셀 다운로드
        $(document).on("click", "#excelMemberDownload", function() {
            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let memberSeqList = [];

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   memberSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            let params = {
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword,
                'memberSeqList' : memberSeqList
            };

            $("#dataJson").val(JSON.stringify(params));
            $('#frmDefault').attr ('action', '/member/excel/download-member-excel').submit();
        });

        // 회원 일괄 등록 팝업
        $(document).on("click", "#excelMemberUpload", function() {
            PopupReg1("insert-member-list-popup", 650, 400, "popup");
        });

        $(document).ready(function() {
            //검색 버튼
            $("#searchBtn").click(function() {
                getUserList(1);
            });

            $("#searchKeyword").on("keyup",function(key){
                if(key.keyCode==13) {
                    getUserList(1);
                }
            });

            getUserList();
        });

    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <div class="home-section-wrap">
                <div>
                    <h2 class="sec-title">회원 관리</h2>
                    <p class="txt">회원 리스트 조회</p>
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
<%--                                        <input type="text" name="startDate" id="startReg" title="등록일자 시작일 입력" value="" autocomplete='off'> ~--%>
<%--                                        <span id="endD"> <input type="text" name="endDate" id="endReg" title="등록일자 만료일 입력" value="" autocomplete='off'></span>--%>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row" style="border-bottom-left-radius: 6px;"><em>검색어</em></th>
                                <td style="cursor: default;">
                                    <div class="basic-select-box" style="width: 10%; display: inline-block;">
                                        <select id="searchType" name="searchType" style="">
                                            <option value="memberId">아이디</option>
                                            <option value="memberNm">이름</option>
                                            <option value="memberEmail">이메일</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                    <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요." style="height: 34px;">
                                    <span class="border-focus"><i></i></span>
                                    <button type="button" class="search-btn" id="searchBtn">
                                        <img src="../../asset/img/admin/icon-search.svg" alt="검색하기">
                                    </button>
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
