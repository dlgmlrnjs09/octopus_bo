<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<div class="table-contents-wrap"  style="background-color: #fff; padding: 20px;">
    <div class="common-table-top">
        <div class="left-wrap">
            <h3 class="table-title">주문 내역 리스트</h3>
        </div>
        <div class="right-wrap">
            <button type="button" class="common-btn excel-download" aria-label="title" id="excelOrderDownload"><span>엑셀 다운로드</span></button>
            <div class="basic-select-box">
                <select>
                    <option value="판매수량순">판매수량순</option>
                    <option value="판매가순">판매가순</option>
                    <option value="c">c</option>
                    <option value="d">d</option>
                </select>
                <span class="border-focus"><i></i></span>
            </div>
            <div class="basic-select-box">
                <select name="pageSize" id="pageSize" onchange="getOrderList(1)">
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
            <caption class="hidden">주문 조회 테이블</caption>
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
                    <div class="con-th">주문 번호</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">주문 상태</div>
                </th>
                <th class="cell-th"> <!-- 상품명 외 1개 이런식으로 표현 -->
                    <div class="con-th">상품명</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 이름</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 아이디</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">휴대전화번호</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">결제금액</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">주문 일시</div>
                </th>
            </tr>
            </thead>
            <tbody class="cursor-point">
            <c:choose>
                <c:when test="${fn:length(orderList) == 0}">
                    <tr class="empty">
                        <td colspan="10" class="empty"><p>검색결과가 없습니다.</p></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orderList}" varStatus="status">
                        <tr>
                            <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                            <td class="cell-td check-td">
                                <div class="basic-check-box">
                                    <input type="checkbox" name="select" id="chk_${order.orderSeq}" tabindex="-1" class="chkgroup table-check-box">
                                    <label for="chk_${order.orderSeq}" tabindex="0"></label>
                                </div>
                            </td>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.orderNo}</div></td>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.orderStatus}</div></td>
                            <c:choose>
                                <c:when test="${fn:length(order.productList) > 1}">
                                    <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.productList[0].product_name} 외 ${fn:length(order.productList)-1}개</div></td>
                                </c:when>
                                <c:otherwise>
                                    <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.productList[0].product_name}</div></td>
                                </c:otherwise>
                            </c:choose>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.memberNm}</div></td>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.memberId}</div></td>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.memberPhoneFull}</div></td>
                            <td class="cell-td dt-right orderData" data-oseq="${order.orderSeq}"><div class="con-td"><fmt:formatNumber value="${order.orderTotalPrice}" pattern="#,###"/> 원</div></td>
                            <td class="cell-td orderData" data-oseq="${order.orderSeq}"><div class="con-td">${order.regDt}</div></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
    <!--페이징-->
    <div class="common-table-bottom">
        <div class="left-wrap" style="width: 342px;">
            <button type="button" id="excelDeliveryNoUpload" style="padding: 10px; font-size: 16px; margin-right: 10px;" class="common-btn" aria-label="title"><span>운송장 일괄 등록</span></button>
        </div>
        <div class="pagination-wrap">
            <button class="pagination-btn first" title="첫 페이지" onclick="getOrderList(1)">첫 페이지</button>
            <button class="pagination-btn prev" title="이전 페이지" onclick="getOrderList(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
            <ul class="pagination-list">
                <c:choose>
                    <c:when test="${fn:length(orderList) == 0}">
                        <li class="current"><button onclick="getOrderList(1)">1</button></li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
                            <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="getOrderList(${i})">${i}</button></li>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
            <button class="pagination-btn next" title="다음 페이지" onclick="getOrderList(${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
            <button class="pagination-btn last" title="마지막 페이지" onclick="getOrderList(${pagingModel.endPage})">마지막 페이지</button>
        </div>
        <div class="right-wrap">
            <button type="button" data-status="OC" name="orderStatusBtn" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>주문취소</span></button>
            <button type="button" data-status="FD" name="orderStatusBtn" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>환불처리</span></button>
            <button type="button" data-status="RP" name="orderStatusBtn" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>반품처리</span></button>
        </div>
    </div>
</div>
