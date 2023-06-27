<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<table id="dataTable" class="common-table" style="width:100%;">
    <caption class="hidden">접속기록 테이블</caption>
    <!-- colgroup 대신 css로 적용 -->
    <thead style="font-weight:bold;">
    <tr>
        <th>번호</th>
        <th>회원 아이디</th>
        <th>회원 아이피</th>
        <c:if test="${type eq 'download'}">
            <th>다운로드 목적</th>
        </c:if>
        <c:if test="${type eq 'login'}">
            <th>성공 여부</th>
        </c:if>
        <th>등록일</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${fn:length(logList) == 0}">
            <tr>
                <td colspan="5" style="text-align: center;">조회 결과가 없습니다.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="log" items="${logList}" varStatus="status">
                <tr>
                    <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                    <td class="logData" data-seq="${log.log_seq}">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</td>
                    <td class="logData" data-seq="${log.log_seq}">${log.log_id}</td>
                    <td class="logData" data-seq="${log.log_seq}">${log.log_ip}</td>
                    <c:if test="${type eq 'download'}">
                        <td class="logData" data-seq="${log.log_seq}">${log.log_reason}</td>
                    </c:if>
                    <c:if test="${type eq 'login'}">
                        <td class="logData" data-seq="${log.log_seq}">${log.is_success ? '성공' : '실패'}</td>
                    </c:if>
                    <td class="logData" data-seq="${log.log_seq}">${log.reg_dt}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>
<!--페이징-->
<div style="margin-top: 20px;">
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
</div>
<div style="margin-top: 20px; float: right;">
</div>
