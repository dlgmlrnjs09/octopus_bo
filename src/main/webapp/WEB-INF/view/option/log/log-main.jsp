<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>개인정보 접속기록 관리</title>
</head>
<body>
    <script>

        // datepicker init
        $(function () {
            initDatePicker($("#startReg"), $("#endReg"));
        });

        // 로그 리스트 조회
        function getLogList(type, page) {

            if(type == 'download') {
                $(".txt").text('다운로드 기록');
            } else if(type == 'login') {
                $(".txt").text('로그인 기록');
            }
            $("#type").val((type) ? type : 'download');

            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let params = {
                'curPage' : (page) ? page : '1',
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword,
                'type' : (type) ? type : 'download'
            };

            $.ajax({
                type : "GET",
                url : "/admin-log/select-log-list",
                dataType:"html",
                data : params,
                success : function(data){
                    // 초기화
                    $(".dataTableDiv").empty();

                    $(".dataTableDiv").html(data);
                }
            });
        }

        $(document).ready(function() {
            //검색 버튼
            $("#searchBtn").click(function() {
                let type = $("#type").val();
                getLogList(type, 1);
            });

            $("#searchKeyword").on("keyup",function(key){
                if(key.keyCode==13) {
                    let type = $("#type").val();
                    getLogList(type, 1);
                }
            });

            getLogList();
        });

    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <div class="home-section-wrap">
                <section class="section home-sec">
                    <form id="frmDefault" name="default" action="" method="post">
                        <input type="hidden" id="type" name="type" value="">
                        <table class="common-table" summary="검색" style="width:100%;">
                            <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등록일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
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
                                <th class="row-th" scope="row"><div class="con-th">검색어</div></th>
                                <td class="cell-td dt-left">
                                    <div class="common-sel-sch-wrap">
                                        <div class="basic-select-box">
                                            <select id="searchType" name="searchType" style="">
                                                <option value="logId">아이디</option>
                                                <option value="logIp">아이피</option>
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

            <div class="tab-container">
<%--                <div class="common-table-top">--%>
<%--                    <div class="left-wrap">--%>
<%--                        <h3 class="table-title">주문 내역 리스트</h3>--%>
<%--                    </div>--%>
<%--                </div>--%>
                <ul class="tab-menu" style="padding: 20px; padding-bottom: 0px; background-color: #fff; border-radius: 6px 6px 0px 0px;">
                    <li class="slider" style="left: 0px;"></li>
                    <li class="tab-link current" data-tab="tab-1"><a href="javascript:;" onclick="getLogList('download', 1);"><span>다운로드 기록</span></a></li>
                    <li class="tab-link" data-tab="tab-2"><a href="javascript:;" onclick="getLogList('login', 1);"><span>로그인 기록</span></a></li>
                </ul>
<%--                <div class="home-section-wrap">--%>
<%--                    <section class="section home-sec" style="border: 0px solid; border-radius: 0px 0px 6px 6px;">--%>
                        <div class="tab-content-wrap" style="margin-bottom: 10px;">
                            <div id="tab-1" class="tab-content current">
                                <div class="dataTableDiv">
                                </div>
                            </div>
                            <div id="tab-2" class="tab-content">
                                <div class="dataTableDiv">
                                </div>
                            </div>
                        </div>
<%--                    </section>--%>
<%--                </div>--%>
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
