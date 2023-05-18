<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<body>
<table id="dataTable" class="common-table" style="width:100%;">
    <caption class="hidden">회원 조회 테이블</caption>
    <!-- colgroup 대신 css로 적용 -->
    <thead style="font-weight:bold;">
    <tr>
        <th>번호</th>
        <th>회원 아이디</th>
        <th>회원 이름</th>
        <th>휴대전화번호</th>
        <th>회원 이메일</th>
        <th>등록일</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${fn:length(memberList) == 0}">
            <tr>
                <td colspan="5">조회 결과가 없습니다.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="member" items="${memberList}" varStatus="status">
                <tr>
                    <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                    <td>${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</td>
                    <td>${member.memberId}</td>
                    <td>${member.memberNm}</td>
                    <td>${member.memberPhone1}-${member.memberPhone2}-${member.memberPhone3}</td>
                    <td>${member.memberEmailFull}</td>
                    <td>${member.regDt}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>
<!--페이징-->
<div class="pagination-wrap">
    <button class="pagination-btn first" title="첫 페이지" onclick="getUserList(1)">첫 페이지</button>
    <button class="pagination-btn prev" title="이전 페이지" onclick="getUserList(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
    <ul class="pagination-list">
        <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
            <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="getUserList(${i})">${i}</button></li>
        </c:forEach>
    </ul>
    <button class="pagination-btn next" title="다음 페이지" onclick="getUserList(${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
    <button class="pagination-btn last" title="마지막 페이지" onclick="getUserList(${pagingModel.endPage})">마지막 페이지</button>
</div>
</body>
</html>
