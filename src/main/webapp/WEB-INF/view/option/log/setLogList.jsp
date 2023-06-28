<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<div class="table-contents-wrap"  style="background-color: #fff; padding: 20px;">
    <table id="dataTable" class="common-table">
        <caption class="hidden">접속기록 테이블</caption>
        <!-- colgroup 대신 css로 적용 -->
        <thead>
        <tr>
            <th class="cell-th">
                <div class="con-th">번호</div>
            </th>
            <th class="cell-th">
                <div class="con-th">회원 아이디</div>
            </th>
            <th class="cell-th">
                <div class="con-th">회원 아이피</div>
            </th>
            <c:if test="${type eq 'download'}">
            <th class="cell-th">
                <div class="con-th">다운로드 목적</div>
            </th>
            </c:if>
            <c:if test="${type eq 'login'}">
            <th class="cell-th">
                <div class="con-th">성공 여부</div>
            </th>
            </c:if>
            <th class="cell-th">
                <div class="con-th">등록일</div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${fn:length(logList) == 0}">
                <tr class="empty">
                    <td colspan="5" class="empty"><p>검색결과가 없습니다.</p></td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="log" items="${logList}" varStatus="status">
                    <tr>
                        <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                        <td class="cell-td" data-seq="${log.log_seq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                        <td class="cell-td" data-seq="${log.log_seq}"><div class="con-td">${log.log_id}</div></td>
                        <td class="cell-td" data-seq="${log.log_seq}"><div class="con-td">${log.log_ip}</div></td>
                        <c:if test="${type eq 'download'}">
                            <td class="cell-td" data-seq="${log.log_seq}"><div class="con-td">${log.log_reason}</div></td>
                        </c:if>
                        <c:if test="${type eq 'login'}">
                            <td class="cell-td" data-seq="${log.log_seq}"><div class="con-td">${log.is_success ? '성공' : '실패'}</div></td>
                        </c:if>
                        <td class="cell-td" data-seq="${log.log_seq}"><div class="con-td">${log.reg_dt}</div></td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <!--페이징-->
    <div class="common-table-bottom">
        <div class="left-wrap">
        </div>
        <div class="pagination-wrap">
            <button class="pagination-btn first" title="첫 페이지" onclick="getLogList('${type}', 1)">첫 페이지</button>
            <button class="pagination-btn prev" title="이전 페이지" onclick="getLogList('${type}', ${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
            <ul class="pagination-list">
                <c:choose>
                    <c:when test="${fn:length(logList) == 0}">
                        <li class="current"><button onclick="getLogList('${type}', 1)">1</button></li>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
                            <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="getLogList('${type}', ${i})">${i}</button></li>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
            <button class="pagination-btn next" title="다음 페이지" onclick="getLogList('${type}', ${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
            <button class="pagination-btn last" title="마지막 페이지" onclick="getLogList('${type}', ${pagingModel.endPage})">마지막 페이지</button>
        </div>
        <div class="right-wrap">
        </div>
    </div>
</div>
