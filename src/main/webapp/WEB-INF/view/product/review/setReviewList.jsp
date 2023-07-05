<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<div class="table-contents-wrap"  style="background-color: #fff; padding: 20px;">
    <div class="common-table-top">
        <div class="left-wrap">
            <h3 class="table-title">리뷰 리스트</h3>
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
            <caption class="hidden">리뷰 조회 테이블</caption>
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
                    <div class="con-th">내용</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">평점</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 이름</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 아이디</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">등록일</div>
                </th>
            </tr>
            </thead>
            <tbody class="cursor-point">
            <c:choose>
                <c:when test="${fn:length(reviewList) == 0}">
                    <tr class="empty">
                        <td colspan="8" class="empty"><p>검색결과가 없습니다.</p></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="review" items="${reviewList}" varStatus="status">
                        <tr>
                            <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                            <td class="cell-td check-td">
                                <div class="basic-check-box">
                                    <input type="checkbox" name="select" id="chk_${review.reviewSeq}" tabindex="-1" class="chkgroup table-check-box">
                                    <label for="chk_${review.reviewSeq}" tabindex="0"></label>
                                </div>
                            </td>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">${review.productName}</div></td>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">
                            <!-- 30글자 이상일 시 말줄임 표시 -->
                            <c:choose>
                                <c:when test="${fn:length(review.reviewContent) > 30}">
                                    <c:out value="${fn:substring(review.reviewContent, 0, 29)}"/>...
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${review.reviewContent}"/>
                                </c:otherwise>
                            </c:choose>
                            </div></td>
<%--                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">${review.reviewContent}</div></td>--%>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td"><fmt:formatNumber value="${review.starPoint}" pattern=".0"/></div></td>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">${review.memberNm}</div></td>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">${review.regId}</div></td>
                            <td class="cell-td reviewData" data-seq="${review.reviewSeq}"><div class="con-td">${review.regDt}</div></td>
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
            <button class="pagination-btn first" title="첫 페이지" onclick="getReviewList(1)">첫 페이지</button>
            <button class="pagination-btn prev" title="이전 페이지" onclick="getReviewList(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
            <ul class="pagination-list">
                <c:choose>
                    <c:when test="${fn:length(reviewList) == 0}">
                        <li class="current"><button onclick="getReviewList(1)">1</button></li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
                            <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="getReviewList(${i})">${i}</button></li>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
            <button class="pagination-btn next" title="다음 페이지" onclick="getReviewList(${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
            <button class="pagination-btn last" title="마지막 페이지" onclick="getReviewList(${pagingModel.endPage})">마지막 페이지</button>
        </div>
        <div class="right-wrap">
            <button type="button" id="excelReviewDownload" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>엑셀 다운로드</span></button>
        </div>
    </div>
</div>
