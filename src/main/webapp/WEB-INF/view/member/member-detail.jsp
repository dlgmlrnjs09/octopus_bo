<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 관리</title>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraRoadAddr !== ''){
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('memberZipCode').value = data.zonecode;
                    document.getElementById("memberAddr1").value = roadAddr;
                    // document.getElementById("memberAddr2").value = data.jibunAddress;

                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                    if(roadAddr !== ''){
                        document.getElementById("memberAddr2").value = extraRoadAddr.trim();
                    } else {
                        document.getElementById("memberAddr2").value = '';
                    }

                    var guideTextBox = document.getElementById("guide");
                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    if(data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';

                    } else if(data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else {
                        guideTextBox.innerHTML = '';
                        guideTextBox.style.display = 'none';
                    }
                }
            }).open();
        }

        $(document).on("change", "#roleType", function() {
            $("#memberRole").val($(this).val());
        });

        $(document).ready(function() {

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
                    history.back();
                }
            });

            //주소 변경 버튼
            $("#addrModifyBtn").click(function() {
                let toggleText = $("#addrModifyBtn").text();

                if(toggleText == '변경') {
                    $("#addrDiv1").hide();
                    $("#addrDiv2").css('display', 'inline-block');
                    $("#addrModifyBtn").text('취소');
                } else {
                    $("#memberZipCode").val('');
                    $("#memberAddr1").val('');
                    $("#memberAddr2").val('');
                    $("#memberAddrDetail").val('');

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
        <div class="home-section-wrap">
            <div>
                <h2 class="sec-title">회원 관리</h2>
                <p class="txt">회원 정보 상세조회</p>
            </div>
        </div>
        <form id="memberForm" name="memberForm">
            <div class="home-section-wrap">
                <section class="section home-sec notice-sec">
                    <input type="hidden" id="memberSeq" name="memberSeq" value="${member.memberSeq}">
                    <table class="common-table" summary="회원상세정보" style="width:100%;">
                        <colgroup>
                            <col width="10%">
                            <col width="40%">
                            <col width="10%">
                            <col width="40%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row"><em>회원 아이디</em></th>
                            <td style="border-top: 1px solid #c6c9cc; cursor: default;">
                                ${member.memberId}
                            </td>
                            <th scope="row"><em>회원 이름</em></th>
                            <td style="border-top: 1px solid #c6c9cc; cursor: default;">
                                <input type="text" style="width: 45%;" id="memberNm" name="memberNm" value="${member.memberNm}">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><em>휴대전화번호</em></th>
                            <td style="cursor: default;">
                                <input type="text" style="width: 45%;" id="memberPhoneFull" name="memberPhoneFull" value="${member.memberPhone1}-${member.memberPhone2}-${member.memberPhone3}">
                            </td>
                            <th scope="row"><em>생년월일</em></th>
                            <td style="cursor: default;">
                                ${member.memberBirth}
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><em>이메일</em></th>
                            <td style="cursor: default;">
                                <input type="text" id="memberEmailId" name="memberEmailId" style="width: 45%;" value="${member.memberEmailId}"> @ <input type="text" id="memberEmailDomain" name="memberEmailDomain" style="width: 45%;" value="${member.memberEmailDomain}">
                            </td>
                            <th scope="row"><em>등록일</em></th>
                            <td style="cursor: default;">
                                ${member.regDt}
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><em>권한</em></th>
                            <td style="cursor: default;">
                                <div id="roleDiv" style="display: inline-block">
                                    <div class="basic-select-box" style="width:150px;">
                                        <select id="memberRole" name="memberRole" style="">
                                            <option value="A" <c:if test="${member.memberRole eq 'A'}">selected</c:if>>어드민</option>
                                            <option value="M" <c:if test="${member.memberRole eq 'M'}">selected</c:if>>매장관리자</option>
                                            <option value="G" <c:if test="${member.memberRole eq 'G'}">selected</c:if>>일반 회원</option>
                                        </select>
                                        <span class="border-focus"><i></i></span>
                                    </div>
                                </div>
                                <button type="button" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" class="common-btn" aria-label="title" id="roleModifyBtn"><span>변경</span></button>
                            </td>
                            <th scope="row"><em>상태</em></th>
                            <td style="cursor: default;">
                                활성화
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" style="border-bottom-left-radius: 6px;"><em>주소</em></th>
                            <td style="cursor: default;" colspan="4">
                                <div id="addrDiv1" style="display: inline-block;">
                                    <span>${member.memberAddrDetail}</span>
                                </div>
                                <div id="addrDiv2" style="display: none;">
                                    <input type="text" id="memberZipCode" name="memberZipCode" placeholder="우편번호" readonly>
                                    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
                                    <input type="text" id="memberAddr1" name="memberAddr1" placeholder="도로명주소" readonly>
                                    <input type="text" id="memberAddr2" name="memberAddr2" placeholder="참고항목" readonly>
                                    <span id="guide" style="color:#999;display:none"></span>
                                    <input type="text" id="memberAddrDetail" name="memberAddrDetail" placeholder="상세주소">
                                </div>
                                <button type="button" style="padding: 8px 5px; font-size: 15px; min-width: 60px; margin-left: 10px;" class="common-btn" aria-label="title" id="addrModifyBtn"><span>변경</span></button>

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
    </main>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
