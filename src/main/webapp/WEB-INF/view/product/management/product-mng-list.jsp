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
                            <th class="row-th" scope="row"><div class="con-th">등록일</div></th>
                            <td class="cell-td dt-left">
                                <div class="con-td">
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="startDate" id="startDate" title="등록일자 시작일 입력" value="${startDate}" autocomplete='off'>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                    ~
                                    <div class="datepicker-box-wrap" style="display: inline-block">
                                        <div class="input-box datepicker-box">
                                            <input type="text" class="" name="endDate" id="endDate" title="등록일자 만료일 입력" value="${endDate}" autocomplete='off'>
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
                                            <option value="product_name" <c:if test="search_type == 'product_name'">selected</c:if> >상품명</option>
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
                        <div class="common-table-top">
                            <div class="left-wrap">
                                <h3 class="table-title">상품 리스트</h3>
                            </div>
                            <div class="right-wrap">
                                <div class="common-sel-sch-wrap">
                                    <div class="basic-select-box">
                                        <select>
                                            <option value="상품코드 검색">상품코드 검색</option>
                                            <option value="상품명 검색">상품명 검색</option>
                                            <option value="c">c</option>
                                            <option value="d">d</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                    <div class="common-sch-box">
                                        <div class="input-box text">
                                            <input class="common-search" type="text" placeholder="검색어를 입력하세요.">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                        <button title="검색하기" type="button" class="search-btn" tabindex="0"><img src="../../asset/img/icon-search.svg" alt="검색하기"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="common-table-wrap">
                            <table id="dataTable" class="common-table">
                                <caption class="hidden">상품 목록 테이블</caption>
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
                                        <div class="con-th">상품명</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">가격</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">옵션여부</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">등록일</div>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="cursor-point">
                                <c:choose>
                                    <c:when test="${fn:length(productMngList) == 0}">
                                        <tr class="empty">
                                            <td colspan="7" class="empty"><p>검색결과가 없습니다.</p></td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="productInfo" items="${productMngList}" varStatus="status">
                                            <tr onclick="goView(${productInfo.product_seq})">
                                                <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                                                <td class="cell-td check-td">
                                                    <div class="basic-check-box">
                                                        <input type="checkbox" name="select" id="chk_${productInfo.product_seq}" tabindex="-1" class="chkgroup table-check-box">
                                                        <label for="chk_${productInfo.product_seq}" tabindex="0"></label>
                                                    </div>
                                                </td>
                                                <td class="cell-td" data-seq="${productInfo.product_seq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                                                <td class="cell-td" data-seq="${productInfo.product_seq}"><div class="con-td">${productInfo.product_name}</div></td>
                                                <td class="cell-td dt-right" data-seq="${productInfo.product_seq}">
                                                    <div class="con-td">
                                                    <c:choose>
                                                        <c:when test="${productInfo.is_discount}">
<%--                                                            ${productInfo.discount_price}--%>
                                                            <fmt:formatNumber value="${productInfo.discount_price}" pattern="#,###"/>
                                                        </c:when>
                                                        <c:otherwise>
<%--                                                            ${productInfo.product_price}--%>
                                                            <fmt:formatNumber value="${productInfo.product_price}" pattern="#,###"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    </div>
                                                </td>
                                                <td class="cell-td" data-seq="${productInfo.product_seq}"><div class="con-td">${productInfo.is_has_option}</div></td>
                                                <td class="cell-td" data-seq="${productInfo.product_seq}"><div class="con-td">${productInfo.reg_dt}</div></td>
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
                                        <select>
                                            <option value="10">10</option>
                                            <option value="20">20</option>
                                            <option value="30">30</option>
                                            <option value="전체">전체</option>
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
                                        <c:when test="${fn:length(productMngList) == 0}">
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
                                <button type="button" id="excelMemberUpload" style="padding: 10px; font-size: 16px; margin-right: 10px;" class="common-btn" onclick="goView(null)" aria-label="title"><span>상품 등록</span></button>
                                <button type="button" id="excelMemberUpload" style="padding: 10px; font-size: 16px; margin-right: 10px;" class="common-btn" aria-label="title"><span>상품 일괄 등록</span></button>
                                <button type="button" id="excelMemberDownload" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>엑셀 다운로드</span></button>
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
        initDatePicker($("#startDate"), $("#endDate"))
    });

    function pageChange(num) {
        $("input[name='curPage']").val(num);
        $("input[name='pageSize']").val($("select[name='pageSize']").val());
        let frm = $("#frm");
        frm.attr("action", "<c:url value="/product/management/list"/>");
        frm.submit();
    }

    function goSearch(num) {
        $("input[name='curPage']").val(num);
        $("input[name='pageSize']").val($("select[name='pageSize']").val());
        let frm = $("#search-frm");
        frm.attr("action", "<c:url value="/product/management/list"/>");
        frm.submit();
    }

    function goView(seq) {
        $("input[name='seq']").val(seq);
        let frm = $("#frm");
        frm.attr("action", "<c:url value="/product/management/detail"/>");
        frm.submit();
    }
</script>