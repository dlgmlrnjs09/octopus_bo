<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 등급 관리</title>
    <style>
        .setting-wrap {
            border-radius: 6px;
            border: 1px solid var(--sub-color01);
            padding: 1vh;
            margin: 0 0 2vh 0;
        }
    </style>
</head>
<body>
    <script>
        function goView(seq) {
            if (seq) {
                $("input[name='seq']").val(seq);
            } else { //신규등록
                $("input[name='seq']").val('');
            }
            let frm = $("#frm");
            frm.attr("action", "<c:url value="/member/membership/detail"/>");
            frm.submit();
        }

        function goMemberView(seq) {
            window.location.href = '/member/main?srchMembershipSeq='+seq;
        }

        function saveMembershipPriority() {
            let dataArray = [];
            let dupChkArray = [];
            $('input[name=membershipPriority]').each(function () {
                if ($(this).val() == 0 || $(this).val() == '') {
                    action_popup.noti('0보다 큰 값을 입력해주세요.');
                    return false;
                }

                let params = {
                    "membershipPriority" : $(this).val(),
                    "membershipSeq" : $(this).data('seq')
                }
                dataArray.push(params);
                dupChkArray.push($(this).val());
            });

            //중복체크
            const set = new Set(dupChkArray);
            if (dupChkArray.length > set.size) {
                action_popup.noti('우선순위가 중복되지 않게 입력해주세요.');
                return false;
            }

            let paramList = {
                "paramList" : JSON.stringify(dataArray)
            }

            $.ajax({
                method: 'post',
                url: '/member/membership/priority/update',
                data: paramList,
                dataType: 'json',
                success: function (res) {
                    if (res.result == 'success') {
                        action_popup.alert('저장되었습니다.');
                    }
                }
            })
        }

        function changeUpdateTerm(val) {
            $.ajax({
                method: 'post',
                url: '/member/membership/update-peroid/'+val,
                dataType: 'text',
                success: function (res) {
                    (val == 9999) ? val = '전체 기간으' : val = val + '개월'
                    action_popup.noti(val+'로 변경되었습니다.');
                }
            })
        }
    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">

        <form name="frm" id="frm" action="" method="get">
            <input type="hidden" name="seq" value="">
        </form>

        <div class="admin-section-wrap">
            <div class="home-section-wrap">
                <section class="section home-sec">
                    ※ 등급 기준금액이 설정된 경우 매일 <font color="#69649C">오전 1시</font>에
                    <div class="basic-select-box" style="display: inline-block;">
                        <select onchange="changeUpdateTerm(this.value);">
                            <option value="9999">전체기간</option>
                            <option value="1" <c:if test="${sumOrderPeriod eq 1}">selected</c:if>>최근 1 개월</option>
                            <option value="3" <c:if test="${sumOrderPeriod eq 3}">selected</c:if>>최근 3 개월</option>
                            <option value="6" <c:if test="${sumOrderPeriod eq 6}">selected</c:if>>최근 6 개월</option>
                            <option value="12" <c:if test="${sumOrderPeriod eq 12}">selected</c:if>>최근 12개월</option>
                            <option value="24" <c:if test="${sumOrderPeriod eq 24}">selected</c:if>>최근 24개월</option>
                            <option value="36" <c:if test="${sumOrderPeriod eq 36}">selected</c:if>>최근 36개월</option>
                        </select>
                        <span class="border-focus"><i></i></span>
                    </div>
                    의 누적 구매금액을 기준으로 자동 변경됩니다. <br>
                    ※ 회원의 현재 등급이 <font style="font-weight: bold">수동으로 설정된 등급일 경우</font> 해당 회원은 자동으로 변경되지 않습니다.
                </section>
            </div>
            <section class="section home-sec">
                <div id="dataTableDiv">
                    <div class="table-contents-wrap"  style="background-color: #fff; padding: 20px;">
                        <div class="common-table-top">
                            <div class="left-wrap">
                                <h3 class="table-title">회원 등급 리스트</h3>
                            </div>
                        </div>
                        <div class="common-table-wrap">
                            <table id="dataTable" class="common-table">
                                <caption class="hidden">회원등급 테이블</caption>
                                <colgroup>
                                    <col width="7%">
                                    <col width="8%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="10%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th class="cell-th">
                                        <div class="con-th">우선순위</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">등급명</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">등급 설명</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">등급 기준금액</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">할인 혜택</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">적립 혜택</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">배송비 혜택</div>
                                    </th>
                                    <th class="cell-th">
                                        <div class="con-th">회원수</div>
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="cursor-point">
                                <c:forEach var="list" items="${membershipList}">
                                    <tr onclick="goView(${list.membership_seq})">
                                        <td class="cell-td" onclick="event.cancelBubble=true" style="padding: 4px 20px;">
                                            <c:if test="${list.membership_is_auto eq true}">
                                                <div class="input-box text">
                                                    <input type="text" name="membershipPriority" value="${list.membership_priority}" data-seq="${list.membership_seq}" style="text-align: center;" maxlength="2">
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td class="cell-td">
                                                ${list.membership_name}
                                        </td>
                                        <td class="cell-td">
                                                ${list.membership_description}
                                        </td>
                                        <td class="cell-td">
                                            <c:choose>
                                                <c:when test="${list.membership_is_auto eq true}">
                                                    <fmt:formatNumber value="${list.membership_auto_amount}" pattern="#,###"/>원 이상
                                                </c:when>
                                                <c:otherwise>수동</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="cell-td">
                                            <c:choose>
                                                <c:when test="${fn:contains(list.benefit_flag, 'discount')}">
                                                    <fmt:formatNumber value="${list.dc_min_amount}" pattern="#,###"/>원 이상 구매시
                                                    <fmt:formatNumber value="${list.dc_rate}" pattern="#,###"/>${list.dc_init}
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="cell-td">
                                            <c:choose>
                                                <c:when test="${fn:contains(list.benefit_flag, 'mileage')}">
                                                    <fmt:formatNumber value="${list.mg_min_amount}" pattern="#,###"/>원 이상 구매시
                                                    <fmt:formatNumber value="${list.mg_rate}" pattern="#,###"/>${list.mg_init}
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="cell-td">
                                            <c:choose>
                                                <c:when test="${fn:contains(list.benefit_flag, 'delivery')}">
                                                    <fmt:formatNumber value="${list.dv_min_amount}" pattern="#,###"/>원 이상 구매시 무료
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="cell-td" onclick="event.cancelBubble=true; goMemberView(${list.membership_seq});">
                                                ${list.member_cnt}명
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="common-table-bottom">
                            <div class="left-wrap">
                                <button type="button" onclick="saveMembershipPriority()" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>저장</span></button>
                            </div>
                            <div class="right-wrap">
                                <button type="button" onclick="goView()" style="padding: 10px; font-size: 16px;" class="common-btn" aria-label="title"><span>신규등록</span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
