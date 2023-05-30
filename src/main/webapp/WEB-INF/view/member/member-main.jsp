<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 관리</title>
</head>
<body>
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

        // 회원 리스트 조회
        function getUserList(page) {

            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let sDate = new Date(startDate);
            let eDate = new Date(endDate);

            if(sDate > eDate) {
                alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
                $("#startReg").val(endDate);
                return false;
            }

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
                    $("#dataTable").empty();

                    $("#dataTable").html(data);
                }
            });
        }

        // 회원 정보 상세 페이지
        $(document).on("click", ".memberData", function() {
            let seq = $(this).data("seq")
            window.location.href = "/member/member-detail?memberSeq=" + seq;
        });

        // 회원 정보 엑셀 다운로드
        $(document).on("click", "#excelMemberDownload", function() {
            let startDate = $("#startReg").val();
            let endDate = $("#endReg").val();
            let searchType = $("#searchType").val();
            let searchKeyword = $("#searchKeyword").val();

            let sDate = new Date(startDate);
            let eDate = new Date(endDate);

            let memberSeqList = [];

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   memberSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            if(sDate > eDate) {
                alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
                $("#startReg").val(endDate);
                return false;
            }

            let params = {
                'startDate' : startDate,
                'endDate' : endDate,
                'searchType' : searchType,
                'searchKeyword' : searchKeyword,
                'memberSeqList' : memberSeqList
            };

            $("#dataJson").val(JSON.stringify(params));
            $('#frmDefault').attr ('action', '/member/download-member-excel').submit();
        });

        // 회원 일괄 등록 팝업
        $(document).on("click", "#excelMemberUpload", function() {
            var w = 650;    //팝업창의 너비
            var h = 350;    //팝업창의 높이
            //중앙위치 구해오기
            LeftPosition=(screen.width-w)/2;
            TopPosition=(screen.height-h)/2;
            window.open(
                "insert-member-list-popup",
                "popup",
                "width="+w+",height="+h+",top="+TopPosition+",left="+LeftPosition+", scrollbars=yes");
            return false;
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

            $('#startReg').datepicker({
                onSelect: function (selectDate) {
                    let orgEndDate = $('#endReg').val();
                    if (orgEndDate !== '' && orgEndDate != null) {
                        let endDate = new Date($('#endReg').val());
                        endDate.setMonth(endDate.getMonth() - 3);
                        if (!isSameDate(new Date(selectDate), endDate)) {
                            if (!(new Date(selectDate) >= endDate)) {
                                alert('날짜의 범위는 3개월을 초과할 수 없습니다.');
                                $('#startReg').datepicker('setDate', endDate).datepicker('fill');
                                return false;
                            }
                        }
                    }
                }
            });

            $("#endReg").datepicker({
                onSelect : function (selectDate) {
                    let orgStartDate = $('#startReg').val();
                    if (orgStartDate !== '' && orgStartDate != null) {
                        let startDate = new Date($('#startReg').val());
                        startDate.setMonth(startDate.getMonth() + 3);
                        if (!isSameDate(new Date(selectDate), startDate)) {
                            if (!(new Date(selectDate) < startDate)) {
                                alert('날짜의 범위는 3개월을 초과할 수 없습니다.');
                                $('#endReg').datepicker('setDate', startDate);
                                return false;
                            }
                        }
                    }
                }
            });

            const isSameDate = (date1, date2) => {
                return date1.getFullYear() === date2.getFullYear()
                    && date1.getMonth() === date2.getMonth()
                    && date1.getDate() === date2.getDate();
            };

            getUserList();
        });

    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="home-section-wrap">
            <div>
                <h2 class="sec-title">회원 관리</h2>
                <p class="txt">회원 리스트 조회</p>
            </div>
        </div>
        <div class="home-section-wrap">
            <section class="section home-sec notice-sec">
                <form id="frmDefault" name="default" action="" method="post">
                    <input type="hidden" id="dataJson" name="dataJson" value="">
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
                                <div class="basic-select-box" style="width: 10%; display: inline-block;">
                                    <select id="searchType" name="searchType" style="">
                                        <option value="memberId">아이디</option>
                                        <option value="memberNm">이름</option>
                                        <option value="memberEmail">이메일</option>
                                    </select>
                                    <span class="border-focus"><i></i></span>
                                </div>
                                <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요." style="height: 43px;">
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
            <section class="section home-sec notice-sec">
                <div id="dataTable">
                </div>
            </section>
        </div>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
