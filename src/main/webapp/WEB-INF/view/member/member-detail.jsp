<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 관리</title>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <script>

        $(document).on("change", "#roleType", function() {
            $("#memberRole").val($(this).val());
        });

        $(document).ready(function() {
            let zipCode = $("#zipCode").val();
            let addr1 = $("#addr1").val();
            let addr2 = $("#addr2").val();
            let addrDetail = $("#addrDetail").val();

            //수정완료 버튼
            $("#modifyBtn").click(function() {
                if(!confirm("수정 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/member/member-update",
                    dataType:"text",
                    data : $("#memberForm").serialize(),
                    success : function(result){
                        if(result == 'success') {
                            alert("수정이 완료되었습니다.");
                            window.location.reload();
                        } else if(result == 'fail') {
                            alert("전화번호 또는 이메일 형식을 다시 확인해주세요.");
                        } else {
                            alert("수정에 문제가 생겼습니다.");
                        }
                    }
                });
            });

            //취소 버튼
            $("#cancelBtn").click(function() {
                if(confirm("수정을 취소하시겠습니까?")) {
                    const queryString = new URLSearchParams(location.search).toString();
                    window.location.href = '/member/main' + '?' + queryString;
                }
            });

            //주소 변경 버튼
            $("#addrModifyBtn").click(function() {
                var guideTextBox = document.getElementById("guide");
                let toggleText = $("#addrModifyBtn").text();

                if(toggleText == '변경') {
                    $("#addrDiv1").hide();
                    $("#addrDiv2").css('display', 'inline-block');
                    $("#addrModifyBtn").text('취소');
                } else {
                    $("#zipCode").val(zipCode);
                    $("#addr1").val(addr1);
                    $("#addr2").val(addr2);
                    $("#addrDetail").val(addrDetail);

                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';

                    $("#addrDiv1").css('display', 'inline-block');
                    $("#addrDiv2").hide();
                    $("#addrModifyBtn").text('변경');
                }
            });

            //권한 변경 버튼
            $("#roleModifyBtn").click(function() {
                if(confirm("권한을 변경하시겠습니까?")) {
                    $.ajax({
                        type : "GET",
                        url : "/member/role-update",
                        dataType:"text",
                        data : $("#memberForm").serialize(),
                        success : function(result){
                            if(result == 'success') {
                                alert("권한 변경이 완료되었습니다.");
                                window.location.reload();
                            } else {
                                alert("변경에 문제가 생겼습니다.");
                            }
                        }
                    });
                }
            });

        });
    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <form id="memberForm" name="memberForm">
                <div class="home-section-wrap">
                    <section class="section home-sec">
                        <input type="hidden" id="memberSeq" name="memberSeq" value="${member.memberSeq}">
                        <table class="common-table" summary="회원상세정보">
                            <colgroup>
                                <col width="10%">
                                <col width="40%">
                                <col width="10%">
                                <col width="40%">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">회원 아이디</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${member.memberId}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">회원 이름</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" style="width: 45%;" id="memberNm" name="memberNm" value="${member.memberNm}">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">휴대전화번호</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" style="width: 45%;" id="memberPhoneFull" name="memberPhoneFull" value="${member.memberPhone1}-${member.memberPhone2}-${member.memberPhone3}">
                                        </div>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">생년월일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${member.memberBirth}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">이메일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" id="memberEmailId" name="memberEmailId" style="width: 45%;" value="${member.memberEmailId}"> @ <input type="text" id="memberEmailDomain" name="memberEmailDomain" style="width: 45%;" value="${member.memberEmailDomain}">
                                        </div>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">등록일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${member.regDt}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">권한</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div id="roleDiv" style="display: inline-block">
                                            <div class="basic-select-box">
                                                <select id="memberRole" name="memberRole" style="">
                                                    <c:forEach var="role" items="${roleList}" varStatus="status">
                                                        <option value="${role.roleSeq}" <c:if test="${member.memberRole eq role.roleId}">selected</c:if>>${role.roleName}</option>
                                                    </c:forEach>
                                                    <option value="" <c:if test="${member.memberRole == null}">selected</c:if>>권한 없음</option>
                                                </select>
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                        <button type="button" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" class="common-btn" aria-label="title" id="roleModifyBtn"><span>변경</span></button>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">상태</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <c:if test="${member.isUse eq true}">
                                            활성화
                                        </c:if>
                                        <c:if test="${member.isUse eq false}">
                                            비활성화
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">주소</div></th>
                                <td class="cell-td dt-left" colspan="4">
                                    <div class="con-td">
                                        <div id="addrDiv1" style="display: inline-block;">
                                            <span>${member.memberAddrFull}</span>
                                        </div>
                                        <div id="addrDiv2" style="display: none;">
                                            <div class="input-box text">
                                                <input style="width: auto;" type="text" id="zipCode" name="memberZipCode" placeholder="우편번호" value="${member.memberZipCode}" readonly>
                                                <input style="width: auto;" type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
                                                <span id="guide" style="color:#999;display:none"></span>
                                                <br>
                                                <input style="width: 313px;" type="text" id="addr1" name="memberAddr1" placeholder="도로명주소" value="${member.memberAddr1}" readonly>
                                                <input style="width: auto;" type="text" id="addr2" name="memberAddr2" placeholder="참고항목" value="${member.memberAddr2}" readonly>
                                                <input style="width: auto;" type="text" id="addrDetail" name="memberAddrDetail" placeholder="상세주소" value="${member.memberAddrDetail}">
                                            </div>
                                        </div>
                                        <button type="button" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" class="common-btn" aria-label="title" id="addrModifyBtn"><span>변경</span></button>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div style="margin-top: 20px; float: right;">
                            <button type="button" id="cancelBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>취소</span></button>
                            <button type="button" id="modifyBtn" style="padding: 10px; font-size: 15px;" class="common-btn" aria-label="title"><span>수정</span></button>
                        </div>
                    </section>
                </div>
            </form>
        </div>
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
