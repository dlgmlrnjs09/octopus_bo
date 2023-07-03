<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--========== CONTENTS ==========-->
<main id="main" class="page-home">
    <div class="admin-section-wrap">
        <form name="frm" id="frm" action="" method="get">
            <input type="hidden" name="pageSize" value="${pagingModel.pageSize}">
            <input type="hidden" name="curPage" value="${pagingModel.curPage}">
            <input type="hidden" name="seq" value="">
        </form>
        <div class="home-section-wrap">
            <section class="section home-sec">
                <form id="search-frm" name="search_frm" action="" method="post">
                    <table class="common-table" summary="검색" style="width:100%;">
                        <tbody>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">발급기간</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="coupon_issue_start_date" id="coupon-issue-start-date" title="발급 시작일 입력" value="${coupon_issue_start_date}" autocomplete='off'>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                    ~
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="coupon_issue_end_date" id="coupon-issue-end-date" title="발급 만료일 입력" value="${coupon_issue_end_date}" autocomplete='off'>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row"><div class="con-th">유효기간</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="coupon_use_start_date" id="coupon-use-start-date" title="사용 시작일 입력" value="${coupon_use_start_date}" autocomplete='off'>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                    ~
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="coupon_use_end_date" id="coupon-use-end-date" title="사용 만료일 입력" value="${coupon_use_end_date}" autocomplete='off'>
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
                                        <select id="searchType" name="search_type" style="">
                                            <option value="coupon_name" <c:if test="${search_type == 'coupon_name'}">selected</c:if> >쿠폰명</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                    <div class="common-sch-box" style="width: 314px;">
                                        <div class="input-box text">
                                            <input type="text" id="search-keyword" name="search_keyword" placeholder="검색어를 입력하세요." value="${search_keyword}" onkeypress="if( event.keyCode === 13 ){goSearch(1);}" style="height: 34px;">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <button type="button" class="search-btn" id="search-btn" onclick="goSearch(1);">
                                            <img src="../../asset/img/icon-search.svg" alt="검색하기">
                                        </button>
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
                    <div class="table-contents-wrap"  style="background-color: #fff; padding: 20px;">
                        <div class="common-table-wrap">
                            <table id="dataTable" class="common-table">
                                <caption class="hidden">쿠폰 목록 테이블</caption>
                                <!-- colgroup 대신 css로 적용 -->
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
                                        <div class="con-th">쿠폰명</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">혜택</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">발급구분</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">적용범위</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">발급기간</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">유효기간</div>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="cursor-point">
                                <c:choose>
                                    <c:when test="${fn:length(couponList) == 0}">
                                        <tr class="empty">
                                            <td colspan="8" class="empty"><p>검색결과가 없습니다.</p></td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="couponInfo" items="${couponList}" varStatus="status">
                                            <tr onclick="goView(${couponInfo.coupon_seq})">
                                                <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                                                <td class="cell-td check-td">
                                                    <div class="basic-check-box">
                                                        <input type="checkbox" name="select" id="chk_${couponInfo.coupon_seq}" tabindex="-1" class="chkgroup table-check-box">
                                                        <label for="chk_${couponInfo.coupon_seq}" tabindex="0"></label>
                                                    </div>
                                                </td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">${couponInfo.coupon_name}</div></td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">
                                                    <c:if test="${couponInfo.coupon_benefit_type == 'amount'}">
                                                        ${couponInfo.coupon_benefit_amount}원
                                                    </c:if>
                                                    <c:if test="${couponInfo.coupon_benefit_type == 'percentage'}">
                                                        ${couponInfo.coupon_benefit_percentage}%
                                                    </c:if>
                                                    할인
                                                </div></td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">
                                                    ${couponInfo.coupon_issue_type_nm}
                                                    <c:if test="${couponInfo.coupon_issue_type == 'conditional'}">
                                                        (${couponInfo.coupon_issue_condition_type_nm})
                                                    </c:if>
                                                </div></td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">${couponInfo.coupon_coverage_type_nm}</div></td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">${couponInfo.coupon_issue_start_date} ~ ${couponInfo.coupon_issue_end_date}</div></td>
                                                <td class="cell-td" data-seq="${couponInfo.coupon_seq}"><div class="con-td">${couponInfo.coupon_use_start_date} ~ ${couponInfo.coupon_use_end_date}</div></td>
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
                                <div class="pager-area" style="width: 327px;">
                                    <div class="basic-select-box">
                                        <select name="pageSize" onchange="pageChange(1)">
                                            <option value="10" <c:if test="${pagingModel.pageSize eq '10'}">selected</c:if>>10</option>
                                            <option value="20" <c:if test="${pagingModel.pageSize eq '20'}">selected</c:if>>20</option>
                                            <option value="30" <c:if test="${pagingModel.pageSize eq '30'}">selected</c:if>>30</option>
                                            <option value="0" <c:if test="${pagingModel.pageSize eq '0'}">selected</c:if>>전체</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                    <span class="total-pager">총 <em>${pagingModel.listCnt}건</em></span>
                                </div>
                            </div>
                            <div class="pagination-wrap">
                                <c:if test="${pagingModel.curRange ne 1 }">
                                    <button class="pagination-btn first" title="첫 페이지" onclick="pageChange(1)">첫 페이지</button>
                                </c:if>
                                <c:if test="${pagingModel.curPage > 5}">
                                    <button class="pagination-btn prev" title="이전 페이지" onclick="pageChange(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
                                </c:if>
                                <ul class="pagination-list">
                                    <c:choose>
                                        <c:when test="${fn:length(couponList) == 0}">
                                            <li class="current"><button onclick="pageChange(1)">1</button></li>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
                                                <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="pageChange(${i})">${i}</button></li>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                                <c:if test="${pagingModel.curPage ne pagingModel.pageCnt and pagingModel.pageCnt > 0 and pagingModel.curRange ne pagingModel.rangeCnt}">
                                    <button class="pagination-btn next" title="다음 페이지" onclick="pageChange(${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
                                </c:if>
                                <c:if test="${pagingModel.curRange ne pagingModel.rangeCnt and pagingModel.rangeCnt > 0 and pagingModel.curPage ne pagingModel.pageCnt}">
                                    <button class="pagination-btn last" title="마지막 페이지" onclick="pageChange(${pagingModel.endPage})">마지막 페이지</button>
                                </c:if>
                            </div>
                            <div class="right-wrap">
                                <button type="button" id="coupon-reg-btn" style="padding: 10px; font-size: 16px; margin-right: 10px;" class="common-btn" onclick="goView(null)" aria-label="title"><span>쿠폰 등록</span></button>
                                <button type="button" id="coupon-excel-download-btn" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>엑셀 다운로드</span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</main>

<script>

    $(function () {
        initDatePicker($("#coupon-issue-start-date"), $("#coupon-issue-end-date"));
        initDatePicker($("#coupon-use-start-date"), $("#coupon-use-end-date"));
    });

    function pageChange(num) {
        $("input[name='curPage']").val(num);
        $("input[name='pageSize']").val($("select[name='pageSize']").val());
        let frm = $("#frm");
        frm.attr("action", "<c:url value="/promotion/coupon/list"/>");
        frm.submit();
    }

    function goSearch(num) {
        $("input[name='curPage']").val(num);
        $("input[name='pageSize']").val($("select[name='pageSize']").val());
        let frm = $("#search-frm");
        frm.attr("action", "<c:url value="/promotion/coupon/list"/>");
        frm.submit();
    }

    function goView(seq) {
        $("input[name='seq']").val(seq);
        let frm = $("#frm");
        frm.attr("action", "<c:url value="/promotion/coupon/detail"/>");
        frm.submit();
    }
</script>