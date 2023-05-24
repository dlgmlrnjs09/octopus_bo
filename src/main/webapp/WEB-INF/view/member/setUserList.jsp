<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<table id="dataTable" class="common-table" style="width:100%;">
    <caption class="hidden">회원 조회 테이블</caption>
    <!-- colgroup 대신 css로 적용 -->
    <thead style="font-weight:bold;">
    <tr>
        <th style="text-align: center;">
            <div class="basic-check-box all-check-box">
                <input type="checkbox" name="selectAll" id="selectAll" tabindex="-1">
                <label for="selectAll" tabindex="0"></label>
            </div>
        </th>
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
                <td colspan="7" style="text-align: center;">조회 결과가 없습니다.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="member" items="${memberList}" varStatus="status">
                <tr>
                    <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                    <td style="text-align: center; cursor: default;">
                        <div class="basic-check-box">
                            <input type="checkbox" name="select" id="chk_${member.memberSeq}" tabindex="-1" class="chkgroup">
                            <label for="chk_${member.memberSeq}" tabindex="0"></label>
                        </div>
                    </td>
                    <td class="memberData" data-seq="${member.memberSeq}">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</td>
                    <td class="memberData" data-seq="${member.memberSeq}">${member.memberId}</td>
                    <td class="memberData" data-seq="${member.memberSeq}">${member.memberNm}</td>
                    <td class="memberData" data-seq="${member.memberSeq}">${member.memberPhoneFull}</td>
                    <td class="memberData" data-seq="${member.memberSeq}">${member.memberEmailFull}</td>
                    <td class="memberData" data-seq="${member.memberSeq}">${member.regDt}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>
<!--페이징-->
<div style="margin-top: 20px;">
    <div class="pagination-wrap">
        <button class="pagination-btn first" title="첫 페이지" onclick="getUserList(1)">첫 페이지</button>
        <button class="pagination-btn prev" title="이전 페이지" onclick="getUserList(${(pagingModel.curPage - 1) < 1 ? 1 : pagingModel.curPage - 1})">이전 페이지</button>
        <ul class="pagination-list">
            <c:choose>
                <c:when test="${fn:length(memberList) == 0}">
                    <li class="current"><button onclick="getUserList(1)">1</button></li>
                </c:when>
                <c:otherwise>
                    <c:forEach var="i" begin="${pagingModel.startPage}" end="${pagingModel.endPage}" step="1">
                        <li class="<c:if test='${pagingModel.curPage eq i}'>current</c:if>"><button onclick="getUserList(${i})">${i}</button></li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </ul>
        <button class="pagination-btn next" title="다음 페이지" onclick="getUserList(${(pagingModel.curPage + 1) > pagingModel.endPage ? pagingModel.endPage : pagingModel.curPage + 1})">다음 페이지</button>
        <button class="pagination-btn last" title="마지막 페이지" onclick="getUserList(${pagingModel.endPage})">마지막 페이지</button>
    </div>
</div>
<div style="margin-top: 20px; float: right;">
    <button type="button" id="excelMemberUpload" style="padding: 10px; font-size: 16px; margin-right: 10px;" class="common-btn" aria-label="title"><span>회원 일괄 등록</span></button>
    <button type="button" id="excelMemberDownload" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>엑셀 다운로드</span></button>
</div>
