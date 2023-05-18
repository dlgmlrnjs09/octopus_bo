<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 관리</title>
</head>
<body>
<div id="container" class="admin">
    <div class="head-area"></div>
    <script>
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            showMonthAfterYear: true,
            yearSuffix: '년'
        });

        $(function(){
            $('.head-area').load("header.html");
        });

        function getUserList(page) {

            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            console.log(startDate,endDate,searchType,searchKeyword);

            let params = {
                'curPage' : (page) ? page : '1',
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword
            };

            $.ajax({
                type : "GET",
                url : "/member/select-user-list",
                dataType:"html",
                data : params,
                success : function(data){
                    let member = data.split('<!--페이징-->')[0];
                    let paging = data.split('<!--페이징-->')[1];

                    console.log(paging);

                    // 초기화
                    $("#dataTable").empty();
                    $("#pagingDiv").empty();

                    $("#dataTable").html(member);
                    $("#pagingDiv").html(paging);

                }
            });
        }

        $(document).ready(function() {
            //검색 버튼
            $("#searchBtn").click(function() {
                getUserList(1);
            });

            $('#startReg').datepicker();
            $('#endReg').datepicker();

            getUserList();
        });

    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <section class="component-sec component-sec00" style="margin-top: 20px;">
            <div class="tit-wrap member-main">
                <h2 class="sec-title">회원 관리</h2>
                <p class="txt">회원 정보 상세조회</p>
            </div>
        </section>
        <div class="home-section-wrap">
            <section class="section home-sec notice-sec">
                <table class="common-table" summary="검색" style="width:100%;">
                    <tbody>
                    <tr>
                        <th scope="row"><em>등록일</em></th>
                        <td style="border-top: 1px solid #c6c9cc; cursor: default;">
                            <div class="field">
                                <input type="text" name="startDate" id="startReg" title="등록일자 시작일 입력" value="" autocomplete='off'> ~
                                <span id="endD"> <input type="text" name="endDate" id="endReg" title="등록일자 만료일 입력" value="" autocomplete='off'></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" style="border-bottom-left-radius: 6px;"><em>검색어</em></th>
                        <td style="cursor: default;">
                            <div class="field">
                                <select id="searchType" name="searchType" style="">
                                    <option value="memberId">아이디</option>
                                    <option value="memberNm">이름</option>
                                    <option value="memberEmail">이메일</option>
                                </select>
                                <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요.">
                                <span class="border-focus"><i></i></span>
                                <button type="button" class="search-btn" id="searchBtn">
                                    <img src="../../asset/img/admin/icon-search.svg" alt="검색하기">
                                </button>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </section>
        </div>
        <div class="home-section-wrap">
            <section class="section home-sec notice-sec">
                <div id="dataTable">
                </div>
                <div style="margin-top: 20px;">
                    <div id="pagingDiv" class="pagination-wrap">
                    </div>
                </div>
            </section>
        </div>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
</div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
