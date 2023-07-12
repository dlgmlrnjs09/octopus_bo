<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--========== CONTENTS ==========-->
<script>
    $(function () {
        initDatePicker($("#startDate"), $("#endDate"));
    });

    function pageChange(num) {
        $("input[name='curPage']").val(num);
        $("input[name='pageSize']").val($("select[name='pageSize']").val());
        let frm = $("#frm");
        frm.attr("action", "<c:url value="/notice/list"/>");
        frm.submit();
    }

    function goSearch(num) {
        $("input[name='curPage']").val(num);
        $("input[name='pageSize']").val($("select[name='pageSize']").val());
        let frm = $("#search-frm");
        frm.attr("action", "<c:url value="/notice/list"/>");
        frm.submit();
    }

    function goView(seq) {
        if (seq) {
            $("input[name='seq']").val(seq);
        } else { //신규등록
            $("input[name='seq']").val('');
        }
        let frm = $("#frm");
        frm.attr("action", "<c:url value="/notice/detail"/>");
        frm.submit();
    }
</script>

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
                            <th class="row-th" scope="row"><div class="con-th">작성일</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="startDate" id="startDate" title="작성일자 시작일 입력" value="${startDate}" autocomplete='off'>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                    ~
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="endDate" id="endDate" title="작성일자 만료일 입력" value="${endDate}" autocomplete='off'>
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
                                            <option value="noticeTitle" <c:if test="${searchType == 'noticeTitle'}">selected</c:if> >제목</option>
                                            <option value="regNm" <c:if test="${searchType == 'regNm'}">selected</c:if> >작성자</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                    <div class="common-sch-box" style="width: 314px;">
                                        <div class="input-box text">
                                            <input type="text" id="search-keyword" name="searchKeyword" placeholder="검색어를 입력하세요." value="${searchKeyword}" onkeypress="if( event.keyCode === 13 ){goSearch(${pagingModel.curPage});}" style="height: 34px;">
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
                                <caption class="hidden">공지사항 테이블</caption>
                                <colgroup>
                                    <col width="10%">
                                    <col width="50%">
                                    <col width="20%">
                                    <col width="20%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th class="cell-th">
                                            <div class="con-th">번호</div>
                                        </th>
                                        <th class="cell-th">
                                            <div class="con-th">제목</div>
                                        </th>
                                        <th class="cell-th">
                                            <div class="con-th">작성자</div>
                                        </th>
                                        <th class="cell-th">
                                            <div class="con-th">작성일</div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="cursor-point">
                                    <c:choose>
                                        <c:when test="${fn:length(noticeList) eq 0}">
                                        <tr class="empty">
                                            <td colspan="4" class="empty"><p>검색결과가 없습니다.</p></td>
                                        </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="noticeInfo" items="${noticeList}" varStatus="status">
                                                <tr onclick="goView(${noticeInfo.notice_seq})">
                                                    <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                                                    <td class="cell-td" data-seq="${noticeInfo.notice_seq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                                                    <td class="cell-td" data-seq="${noticeInfo.notice_seq}"><div class="con-td">${noticeInfo.notice_title}<c:if test="${noticeInfo.reply_cnt gt 0}">(${reply_cnt})</c:if></div></td>
                                                    <td class="cell-td" data-seq="${noticeInfo.notice_seq}"><div class="con-td">${noticeInfo.reg_nm}</div></td>
                                                    <td class="cell-td" data-seq="${noticeInfo.notice_seq}"><div class="con-td">${noticeInfo.reg_dt_str}</div></td>
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
                                <div class="pager-area">
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
                            <c:if test="${pagingModel.pageSize ne '0'}">
                                <div class="pagination-wrap">
                                    <c:if test="${pagingModel.curRange ne 1 }">
                                        <button class="pagination-btn first" title="첫 페이지" onclick="pageChange(1)">첫 페이지</button>
                                    </c:if>
                                    <c:if test="${pagingModel.curPage > 5}">
                                        <button class="pagination-btn prev" title="이전 페이지" onclick="pageChange(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
                                    </c:if>
                                    <ul class="pagination-list">
                                        <c:choose>
                                            <c:when test="${fn:length(noticeList) == 0}">
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
                            </c:if>
                            <div class="right-wrap">
                                <button type="button" onclick="goView()" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>신규등록</span></button>
                            </div>
                        </div>
                        <!-- 페이징 끝 -->


                    </div>
                </div>
            </section>
        </div>
    </div>
</main>