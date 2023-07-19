<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 관리</title>
    <style>
        .fixed-membership {    background-color: #e2b012; border-radius: 4px; color: white; padding: 1px 3px;}
    </style>
</head>
<body>
    <script>
        // datepicker init
        $(function () {
            initPrivacyDatePicker($("#startDate"), $("#endDate"));
        });

        // 회원 리스트 조회
        function getUserList(page) {
            const pageParam = Number(new URLSearchParams(location.search).get('curPage'));
            page = (page) ? page : ((pageParam) ? pageParam : 1);

            // 회원등급 검색조건 처리
            let membershipSeqList = [];

            $('.searchChkgroup:checked').each(function () {
                let seq = $(this).attr('id').split('_')[1];
                membershipSeqList.push(seq);
            });

            const form = document.getElementById('frmDefault');
            let params = {
                'curPage' : page,
                'startDate' : form.startDate.value,
                'endDate' : form.endDate.value,
                'searchType' : form.searchType.value,
                'searchKeyword' : form.searchKeyword.value,
                'membershipSeqList' : membershipSeqList
            };

            // 쿼리스트링을 포함한 URI 세팅
            const queryString = new URLSearchParams(params).toString();
            const replaceUri = location.pathname + '?' + queryString;
            history.replaceState({}, '', replaceUri);

            $.ajax({
                type : "post",
                url : "/member/select-member-list",
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

        // 회원 정보 상세 페이지
        $(document).on("click", ".memberData", function() {
            const queryString = new URLSearchParams(location.search).toString();

            let seq = $(this).data("seq");
            window.location.href = "/member/member-detail?memberSeq=" + seq + "&" + queryString;
        });

        // 회원 리스트 체크박스 전체선택
        $(document).on("click", "#memberChkAll", function() {
            if ( $(this).is(':checked') ) {
                $('.memberChkgroup').prop('checked', true);
            } else {
                $('.memberChkgroup').prop('checked', false);
            }
        });

        //회원등급 검색조건 전체선택
        $(document).on("click", "#searchChkAll", function() {
            if ( $(this).is(':checked') ) {
                $('.searchChkgroup').prop('checked', true);
            } else {
                $('.searchChkgroup').prop('checked', false);
            }
            getUserList();
        });

        // 일괄설정 저장 버튼
        $(document).on("click", ".setMembershipBtn", function() {
            let memberSeqList = [];
            let flagTxt = '';
            const flag = $(this).data('flag');

            $('.memberChkgroup:checked').each(function() {
                memberSeqList.push($(this).attr('id').split('_')[1]);
            });

            let params = {
                'memberSeqList' : memberSeqList,
                'membershipSeq' : $('#membershipSeqSelect').val(),
                'isMembershipFixed' : $('input[name=isMembershipFixed]:checked').val(),
                'flag' : flag
            };

            $.ajax({
                type : "post",
                url : "/member/membership-update",
                dataType : "text",
                contentType : 'application/json; charset=utf-8',
                data : JSON.stringify(params),
                traditional: true,
                success : function(result){
                    if(result == 'success') {
                        action_popup.alert('선택한 회원의 등급 설정이 저장 되었습니다.');
                        getUserList();
                    } else if(result == 'none') {
                        action_popup.alert('선택된 회원이 없습니다.');
                    } else {
                        action_popup.noti('처리에 실패하였습니다.');
                    }
                }
            });

        });

        // 회원 정보 엑셀 다운로드
        $(document).on("click", "#excelMemberDownload", function() {
            let memberSeqList = [];

            $("input:checkbox[name='select']").each(function() {
               if($(this).is(":checked") == true) {
                   memberSeqList.push($(this).attr("id").split("_")[1]);
               }
            });

            const form = document.getElementById('frmDefault');
            let params = {
                'startDate' : form.startDate.value,
                'endDate' : form.endDate.value,
                'searchType' : form.searchType.value,
                'searchKeyword' : form.searchKeyword.value,
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

            // 쿼리스트링 해당 form에 매핑
            setQueryStringParams('frmDefault');
            getUserList();
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
                                                <option value="memberId">아이디</option>
                                                <option value="memberNm">이름</option>
                                                <option value="memberEmail">이메일</option>
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
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">회원 등급</div></th>
                                <td class="cell-td dt-left">
                                    <div class="common-sel-sch-wrap">
                                        <div class="basic-check-box">
                                            <ul class="chkgroup-list" style="display:inline-block;">
                                                <li style="display:inline-block; margin-right:10px;">
                                                    <input type="checkbox" id="searchChkAll" tabindex="-1" <c:if test="${empty srchMembershipSeq}">checked</c:if>>
                                                    <label for="searchChkAll" tabindex="0">전체</label>
                                                </li>
                                                <c:forEach var="map" items="${membershipList}">
                                                    <li style="display:inline-block; margin-right:10px;">
                                                        <input type="checkbox" name="statusSelect" id="chk_${map.membership_seq}" tabindex="-1" class="searchChkgroup" onclick="getUserList();" <c:if test="${srchMembershipSeq eq map.membership_seq or empty srchMembershipSeq}">checked</c:if> >
                                                        <label for="chk_${map.membership_seq}" tabindex="0">${map.membership_name}</label>
                                                    </li>
                                                </c:forEach>
                                            </ul>
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
