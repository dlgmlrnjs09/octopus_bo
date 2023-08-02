<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>상품 문의 관리</title>
</head>
<style>
    .small-symbol-mark { background-color: #bbb; border-radius: 4px; color: white; padding: 1px 3px;}

    .import { background-color: #aa91f8; }
</style>
<body>
    <script>
        // datepicker init
        $(function () {
            initDatePicker($("#startDate"), $("#endDate"));

            //상세 페이지 이동
            $('.cell-td').on('click', function() {
                const seq = $(this).data('seq');
                if (seq != undefined && seq > 0) {
                    $('#seq').val(seq);
                    let frm = $("#frm");
                    frm.attr('action', '<c:url value="/product/inquiry/detail"/>');
                    frm.submit();
                }
            });

            // TODO 엑셀 다운로드
            // $('#excelDownloadBtn').on('click', function() {
            //     let sDate = new Date($("#startDate").val());
            //     let nowDate = new Date();
            //
            //     let chkSeqList = [];
            //
            //     nowDate.setMonth(nowDate.getMonth() - 3);
            //     if(sDate < nowDate) {
            //         alert("주문 기간이 3개월 경과된 내역은 다운로드 할 수 없습니다.");
            //         return false;
            //     }
            //
            //     $('input[name=select]:checked').each(function () {
            //         chkSeqList.push($(this).attr('id').split('_')[1]);
            //     });
            //
            //     const form = document.getElementById('frm');
            //     let params = {
            //         'startDate' : form.startDate.value,
            //         'endDate' : form.endDate.value,
            //         'searchType' : form.searchType.value,
            //         'searchKeyword' : form.searchKeyword.value,
            //         'hasAnswer' : form.hasAnswer.value,
            //         'chkSeqList' : chkSeqList
            //     };
            //
            //     $("#dataJson").val(JSON.stringify(params));
            //     $('#frm').attr ('action', '/order/excel/download-order-excel').submit();
            // });
        });

        //검색, 페이지 이동 버튼
        function getList(num) {
            $("input[name='curPage']").val(num);
            $("input[name='pageSize']").val($("select[name='pageSize']").val());
            let frm = $("#frm");
            frm.attr("action", "<c:url value="/product/inquiry/list"/>");
            frm.submit();
        }

    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <form id="frm" name="frm" action="" method="get">
            <input type="hidden" name="inquirySeq" id="seq">
            <input type="hidden" name="dataJson" id="dataJson">

            <div class="admin-section-wrap">
                <div class="home-section-wrap">
                    <section class="section home-sec">
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
                                                <option value="product_name">상품명</option>
                                                <option value="reg_id">아이디</option>
                                                <option value="title">제목</option>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <div class="common-sch-box" style="width: 314px;">
                                            <div class="input-box text">
                                                <input class="common-search" type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력하세요." value="${searchKeyword}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            <button title="검색하기" type="button" class="search-btn" id="searchBtn" tabindex="0"><img src="../../asset/img/icon-search.svg" alt="검색하기"></button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">답변 완료 여부</div></th>
                                <td class="cell-td dt-left">
                                    <div class="common-sel-sch-wrap">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="hasAnswer_all" name="hasAnswer" value="all" <c:if test="${empty hasAnswer or hasAnswer eq 'all'}">checked</c:if> onclick="getList(${pagingModel.curPage})"/>
                                                <label for="hasAnswer_all"><span>전체</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="hasAnswer_true" name="hasAnswer" value="true" <c:if test="${hasAnswer eq 'true'}">checked</c:if> onclick="getList(${pagingModel.curPage})"/>
                                                <label for="hasAnswer_true"><span>답변완료</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="hasAnswer_false" name="hasAnswer" value="false" <c:if test="${hasAnswer eq 'false'}">checked</c:if> onclick="getList(${pagingModel.curPage})"/>
                                                <label for="hasAnswer_false"><span>미답변</span></label>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </section>
                </div>

                <!-- 목록 시작 -->
                <div class="home-section-wrap">
                    <section class="section home-sec">
                        <div id="dataTableDiv">
                            <div class="table-contents-wrap"  <%--style="background-color: #fff; padding: 20px;"--%>>
                                <div class="common-table-top">
                                    <div class="left-wrap">
                                        <h3 class="table-title">상품 문의 내역</h3>
                                    </div>
                                    <div class="right-wrap">
                                        <%--<button type="button" class="common-btn excel-download" aria-label="title" id="excelDownloadBtn"><span>엑셀 다운로드</span></button>--%>
                                        <div class="basic-select-box">
                                            <select name="pageSize" id="pageSize" onchange="getList(1)">
                                                <option value="10" <c:if test="${pagingModel.pageSize eq '10'}">selected</c:if>>10개씩 보기</option>
                                                <option value="20"<c:if test="${pagingModel.pageSize eq '20'}">selected</c:if>>20개씩 보기</option>
                                                <option value="30" <c:if test="${pagingModel.pageSize eq '30'}">selected</c:if>>30개씩 보기</option>
                                                <option value="0" <c:if test="${pagingModel.pageSize eq '0'}">selected</c:if>>전체</option>
                                            </select>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="common-table-wrap">
                                    <table id="dataTable" class="common-table">
                                        <thead>
                                            <tr>
                                                <th class="cell-th check-th">
                                                    <div class="basic-check-box all-check-box">
                                                        <input type="checkbox" class="table-check-box" name="selectAll" id="selectAll" tabindex="-1">
                                                        <label for="selectAll" tabindex="0"></label>
                                                    </div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">번호</div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">상품명</div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">제목</div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">내용</div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">회원 아이디</div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">등록일시</div>
                                                </th>
                                                <th class="cell-th">
                                                    <div class="con-th">답변 완료 여부</div>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody class="cursor-point">
                                            <c:choose>
                                                <c:when test="${fn:length(inquiryList) eq 0}">
                                                    <tr class="empty">
                                                        <td colspan="8" class="empty"><p>검색결과가 없습니다.</p></td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
                                                        <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                                                        <tr>
                                                            <td class="cell-td check-td">
                                                                <div class="basic-check-box">
                                                                    <input type="checkbox" name="select" id="chk_${inquiry.inquiry_seq}" tabindex="-1" class="chkgroup table-check-box">
                                                                    <label for="chk_${inquiry.inquiry_seq}" tabindex="0"></label>
                                                                </div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <div class="con-td">
                                                                    ${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}
                                                                </div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <div class="con-td">${inquiry.product_name}</div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <c:choose>
                                                                    <c:when test="${inquiry.inquiry_flag eq 'delivery'}"><c:set var="flagNm" value="배송문의"/></c:when>
                                                                    <c:when test="${inquiry.inquiry_flag eq 'product'}"><c:set var="flagNm" value="상품문의"/></c:when>
                                                                    <c:when test="${inquiry.inquiry_flag eq 'warehousing'}"><c:set var="flagNm" value="입고문의"/></c:when>
                                                                    <c:when test="${inquiry.inquiry_flag eq 'order'}"><c:set var="flagNm" value="주문/결제/취소"/></c:when>
                                                                    <c:when test="${inquiry.inquiry_flag eq 'return'}"><c:set var="flagNm" value="반품/교환/환불"/></c:when>
                                                                    <c:when test="${inquiry.inquiry_flag eq 'other'}"><c:set var="flagNm" value="기타"/></c:when>
                                                                    <c:otherwise><c:set var="flag_nm" value="기타"/></c:otherwise>
                                                                </c:choose>
                                                                <div class="con-td">[${flagNm}] ${inquiry.title}</div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <div class="con-td">
                                                                    <!-- 30글자 이상일 시 말줄임 표시 -->
                                                                    <c:choose>
                                                                        <c:when test="${fn:length(inquiry.description) > 30}">
                                                                            <c:out value="${fn:substring(inquiry.description, 0, 29)}"/>...
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <c:out value="${inquiry.description}"/>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <div class="con-td">${inquiry.reg_id}</div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <div class="con-td">${inquiry.reg_dt_char}</div>
                                                            </td>
                                                            <td class="cell-td" data-seq="${inquiry.inquiry_seq}">
                                                                <div class="con-td">
                                                                    <c:choose>
                                                                        <c:when test="${inquiry.answer_cnt eq 0}">
                                                                            <span class="small-symbol-mark import">미답변</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="small-symbol-mark">답변완료</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <!--페이징-->
                                <div class="common-table-bottom">
                                    <div class="left-wrap">
                                    </div>
                                    <c:if test="${pagingModel.pageSize ne '0'}">
                                        <div class="pagination-wrap">
                                            <c:if test="${pagingModel.curRange ne 1 }">
                                                <button class="pagination-btn first" title="첫 페이지" onclick="getList(1)">첫 페이지</button>
                                            </c:if>
                                            <c:if test="${pagingModel.curPage > 5}">
                                                <button class="pagination-btn prev" title="이전 페이지" onclick="getList(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
                                            </c:if>
                                            <ul class="pagination-list">
                                                <c:choose>
                                                    <c:when test="${fn:length(inquiryList) == 0}">
                                                        <li class="current"><button onclick="getList(1)">1</button></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
                                                            <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="getList(${i})">${i}</button></li>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                            <c:if test="${pagingModel.curPage ne pagingModel.pageCnt and pagingModel.pageCnt > 0 and pagingModel.curRange ne pagingModel.rangeCnt}">
                                                <button class="pagination-btn next" title="다음 페이지" onclick="getList(${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
                                            </c:if>
                                            <c:if test="${pagingModel.curRange ne pagingModel.rangeCnt and pagingModel.rangeCnt > 0 and pagingModel.curPage ne pagingModel.pageCnt}">
                                                <button class="pagination-btn last" title="마지막 페이지" onclick="getList(${pagingModel.endPage})">마지막 페이지</button>
                                            </c:if>
                                        </div>
                                    </c:if>
                                    <div class="right-wrap">
                                    </div>
                                </div>
                                <!-- 페이징 끝 -->

                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </form>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>