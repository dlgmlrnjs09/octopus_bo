<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>관리자 관리</title>
</head>
<body>
    <script>

        $(document).on("change", "#roleType", function() {
            $("#adminRole").val($(this).val());
        });

        $(document).ready(function() {
            //수정완료 버튼
            $("#modifyBtn").click(function() {
                if(!confirm("수정 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/admin/admin-update",
                    dataType:"text",
                    data : $("#adminForm").serialize(),
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
                    window.location.href = '/admin/main' + '?' + queryString;
                }
            });

            //권한 변경 버튼
            $("#roleModifyBtn").click(function() {
                if(confirm("권한을 변경하시겠습니까?")) {
                    $.ajax({
                        type : "GET",
                        url : "/admin/role-update",
                        dataType:"text",
                        data : $("#adminForm").serialize(),
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
            <form id="adminForm" name="adminForm">
                <div class="home-section-wrap">
                    <section class="section home-sec">
                        <input type="hidden" id="adminSeq" name="adminSeq" value="${admin.adminSeq}">
                        <table class="common-table" summary="관리자상세정보">
                            <colgroup>
                                <col width="10%">
                                <col width="40%">
                                <col width="10%">
                                <col width="40%">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">관리자 아이디</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${admin.adminId}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">관리자 이름</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" style="width: 45%;" id="adminName" name="adminName" value="${admin.adminName}">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">휴대전화번호</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" style="width: 45%;" id="adminPhoneFull" name="adminPhoneFull" value="${admin.adminPhone1}-${admin.adminPhone2}-${admin.adminPhone3}">
                                        </div>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">생년월일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${admin.adminBirth}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">이메일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" id="adminEmailId" name="adminEmailId" style="width: 45%;" value="${admin.adminEmailId}"> @ <input type="text" id="adminEmailDomain" name="adminEmailDomain" style="width: 45%;" value="${admin.adminEmailDomain}">
                                        </div>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">등록일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${admin.regDt}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">권한</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div id="roleDiv" style="display: inline-block">
                                            <div class="basic-select-box">
                                                <select id="adminRole" name="adminRole" style="">
                                                    <c:forEach var="role" items="${roleList}" varStatus="status">
                                                        <option value="${role.roleSeq}" <c:if test="${admin.adminRoleId eq role.roleId}">selected</c:if>>${role.roleName}</option>
                                                    </c:forEach>
                                                    <option value="" <c:if test="${admin.adminRoleId == null}">selected</c:if>>권한 없음</option>
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
                                        <c:if test="${admin.isDormant eq true}">
                                            활성화
                                        </c:if>
                                        <c:if test="${admin.isDormant eq false}">
                                            활성화
                                        </c:if>
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
