<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<div class="table-contents-wrap"  style="background-color: #fff; padding: 20px;">
    <div class="common-table-top">
        <div class="left-wrap">
            <h3 class="table-title">회원 리스트</h3>
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
            <caption class="hidden">회원 조회 테이블</caption>
            <!-- colgroup 대신 css로 적용 -->
            <thead>
            <tr>
                <th class="cell-th check-th">
                    <div class="basic-check-box all-check-box">
                        <input type="checkbox" class="table-check-box" name="memberChkAll" id="memberChkAll" tabindex="-1">
                        <label for="memberChkAll" tabindex="0"></label>
                    </div>
                </th>
                <th class="cell-th">
                    <div class="con-th">번호</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 아이디</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 이름</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 등급</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">휴대전화번호</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">회원 이메일</div>
                </th>
                <th class="cell-th">
                    <div class="con-th">등록일</div>
                </th>
            </tr>
            </thead>
            <tbody class="cursor-point">
            <c:choose>
                <c:when test="${fn:length(memberList) == 0}">
                    <tr class="empty">
                        <td colspan="7" class="empty"><p>검색결과가 없습니다.</p></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="member" items="${memberList}" varStatus="status">
                        <tr>
                            <!-- 총 개수 - ( ((현재페이지 - 1) * 화면당 게시글 로우행 수) + 로우인덱스) -->
                            <td class="cell-td check-td">
                                <div class="basic-check-box">
                                    <input type="checkbox" name="select" id="chk_${member.memberSeq}" tabindex="-1" class="memberChkgroup table-check-box">
                                    <label for="chk_${member.memberSeq}" tabindex="0"></label>
                                </div>
                            </td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${pagingModel.listCnt - (((pagingModel.curPage - 1) * pagingModel.pageSize) + status.index)}</div></td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${member.memberId}</div></td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${member.memberNm}</div></td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${member.membershipName} <c:if test="${member.isMembershipFixed}"><span class="fixed-membership">고정</span></c:if></div></td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${member.memberPhoneFull}</div></td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${member.memberEmailFull}</div></td>
                            <td class="cell-td memberData" data-seq="${member.memberSeq}"><div class="con-td">${member.regDt}</div></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
    <div class="common-table-top">
        <div class="left-wrap" style="margin-top:20px">
            <h3 class="table-title">일괄 설정</h3>
        </div>
    </div>
    <table class="common-table" summary="검색" style="width:100%;">
        <colgroup>
            <col width="10%">
            <col width="90%">
        </colgroup>
        <tbody>
            <tr>
                <th class="row-th" scope="row"><div class="con-th">회원 등급 변경</div></th>
                <td class="cell-td dt-left">
                    <div class="con-td">
                        <div class="basic-select-box" style="display: inline-block;">
                            <select id="membershipSeqSelect">
                                <c:forEach var="membership" items="${membershipList}">
                                    <option value="${membership.membership_seq}">${membership.membership_name}</option>
                                </c:forEach>
                            </select>
                            <span class="border-focus"><i></i></span>
                        </div>
                        <button type="button" class="common-btn setMembershipBtn" aria-label="title" data-flag="seq" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;">
                            <span>저장</span>
                        </button>
                    </div>
                </td>
            </tr>
            <tr>
                <th class="row-th" scope="row"><div class="con-th">회원 등급 고정</div></th>
                <td class="cell-td dt-left">
                    <div class="con-td">
                        <div class="radio-box-wrap" style="display: inline-block">
                            <div class="basic-radio-box">
                                <input type="radio" id="fixedTrue" name="isMembershipFixed" value="true">
                                <label for="fixedTrue"><span>고정</span></label>
                            </div>
                            <div class="basic-radio-box">
                                <input type="radio" id="fixedFalse" name="isMembershipFixed" value="false" checked>
                                <label for="fixedFalse"><span>고정해제</span></label>
                            </div>
                        </div>
                        <button type="button" class="common-btn setMembershipBtn" aria-label="title" data-flag="fix" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;">
                            <span>저장</span>
                        </button>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    <!--페이징-->
    <div class="common-table-bottom">
        <div class="left-wrap">
            <div class="pager-area" style="width: 224px;">
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
        <div class="right-wrap">
            <button type="button" id="excelMemberUpload" style="padding: 10px; font-size: 16px; margin-right: 10px;" class="common-btn" aria-label="title"><span>회원 일괄 등록</span></button>
            <button type="button" id="excelMemberDownload" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>엑셀 다운로드</span></button>
        </div>
    </div>
</div>
