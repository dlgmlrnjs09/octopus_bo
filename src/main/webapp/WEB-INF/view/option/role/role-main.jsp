<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <link rel="stylesheet" href="/asset/css/admin/menu-tree.css">
    <title>권한 관리</title>
</head>
<body>
    <script>
        function selectRoleDetail(roleSeq) {
            $.ajax({
                type : "GET",
                url : "/role/select-role-detail",
                dataType:"json",
                data : { 'roleSeq' : roleSeq },
                success : function(data){
                    $("#roleName").val(data.roleName);
                    $("#roleId").val(data.roleId);
                    $("#roleDesc").val(data.roleDesc);

                    // 사용 여부
                    // if(data.is_use) {
                    //     $("input:radio[name='isUse']:radio[value='true']").prop('checked', true);
                    // } else {
                    //     $("input:radio[name='isUse']:radio[value='false']").prop('checked', true);
                    // }
                }
            });
        }

        $(document).on("click", ".treeItem", function() {
            let roleSeq = $(this).attr('value');

            $("#roleSeq").val(roleSeq);

            $("a").removeClass("on");
            $(this).addClass("on");

            $("#modifyBtn").show();
            $("#insertBtn").text('추가');
            $("#roleId").attr("readonly", true);

            selectRoleDetail(roleSeq);
        });


        $(document).ready(function() {

            //수정 버튼
            $("#modifyBtn").click(function() {
                if($("#roleSeq").val() == '') {
                    alert("권한을 선택해주세요.");
                    return false;
                }
                if($("#roleName").val().trim() == '') {
                    alert("권한 이름을 작성해주세요.");
                    $("#roleName").focus();
                    return false;
                }
                if($("#roleId").val().trim() == '') {
                    alert("권한 코드를 작성해주세요.");
                    $("#roleId").focus();
                    return false;
                }

                if(!confirm("수정 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/role/update-role",
                    dataType:"text",
                    data : $("#roleForm").serialize(),
                    success : function(result){
                        if(result == '1') {
                            alert("수정이 완료되었습니다.");
                           window.location.reload();
                        } else {
                            alert("수정에 문제가 생겼습니다.");
                        }
                    }
                });
            });

            //추가 버튼
            $("#insertBtn").click(function() {
                // input 초기화
                if($("#roleSeq").val() != '') {
                    $("#roleName").val('');
                    $("#roleId").val('');
                    $("#roleDesc").val('');
                    $("#roleSeq").val('');

                    $("#modifyBtn").hide();
                    $("#insertBtn").text('저장');
                    $("#roleId").removeAttr("readonly");
                    return false;
                }

                if($("#roleName").val().trim() == '') {
                    alert("권한 이름을 작성해주세요.");
                    $("#roleName").focus();
                    return false;
                }
                if($("#roleId").val().trim() == '') {
                    alert("권한 코드를 작성해주세요.");
                    $("#roleId").focus();
                    return false;
                }

                if(!confirm("권한을 추가 하시겠습니까?")) {
                    return false;
                }

                $.ajax({
                    type : "POST",
                    url : "/role/insert-role",
                    dataType:"text",
                    data : $("#roleForm").serialize(),
                    success : function(result){
                        if(result == '1') {
                            alert("저장이 완료되었습니다.");
                           window.location.reload();
                        } else {
                            alert("저장에 문제가 생겼습니다.");
                        }
                    }
                });
            });
        });
    </script>

    <!--========== CONTENTS ==========-->
    <div class="workingbox clfix">
        <div class="working_box_l clfix">
            <section class="section home-sec">
                <div class="left_area">
                    <div class="title_area">
                        <h2 class="tit_h2">권한 관리</h2>
                    </div>
                    <ul id="treeBasic" class="tree_area">
                    <c:forEach varStatus="status" items="${roleList}" var="role">
                        <li style="padding-bottom: 10px;">
                            <a class="treeItem" href="javascript:;" value="${role.roleSeq}"><c:out value="${role.roleName}"/></a>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
            </section>
        </div>
        <div id="divContent" class="working_box_r clfix">
            <section class="section home-sec">
                <div id="divBasicInfo" class="data_cont marT20">
                    <form id="roleForm" name="roleForm" action="" method="post">
                        <input type="hidden" id="roleSeq" name="roleSeq" value="">
                        <table summary="권한 상세" class="common-table">
                            <caption style="display: none;">권한 상세</caption>
                            <colgroup>
                                <col width="18%" /><col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="row-th" scope="row"><div class="con-th">권한 이름</div></th>
                                    <td class="cell-td dt-left">
                                        <div class="con-td">
                                            <div class="input-box text">
                                                <input style="width: auto;" class="text_e w98p" value="" type="text" id="roleName" name="roleName"/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="row-th" scope="row"><div class="con-th">권한 코드</div></th>
                                    <td class="cell-td dt-left">
                                        <div class="con-td">
                                            <div class="input-box text">
                                                <input style="width: auto;" class="text_e w98p" value="" type="text" id="roleId" name="roleId"/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="row-th" scope="row"><div class="con-th">권한 설명</div></th>
                                    <td class="cell-td dt-left">
                                        <div class="con-td">
                                            <div class="input-box text">
                                                <input style="width: auto;" class="text_e w98p" value="" type="text" id="roleDesc" name="roleDesc"/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
<%--                                <tr>--%>
<%--                                    <th class="last" scope="row" style="border-bottom-left-radius: 6px;"><em>사용여부</em></th>--%>
<%--                                    <td class="last cursor-default">--%>
<%--                                        <div class="radio-box-wrap">--%>
<%--                                            <div class="basic-radio-box">--%>
<%--                                                <input type="radio" id="radio01" name="isUse" value="true" checked>--%>
<%--                                                <label for="radio01"><span>사용</span></label>--%>
<%--                                            </div>--%>
<%--                                            <div class="basic-radio-box">--%>
<%--                                                <input type="radio" id="radio02" name="isUse" value="false">--%>
<%--                                                <label for="radio02"><span>사용안함</span></label>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </td>--%>
<%--                                </tr>--%>
                            </tbody>
                        </table>
                    </form>
                    <div class="btnR">
                        <div id="defaultBtnDiv">
                            <button id="modifyBtn" class="common-btn" type="button" value="modify" style="display: none;"><span><span class="size01">수정</span></span></button>
                            <button id="insertBtn" class="common-btn" type="button" value="insert"><span><span class="size01">추가</span></span></button>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <div id="top-btn">
        <a href="javascript:;" tabindex="0"><span class="hidden">페이지 맨 위로</span></a>
    </div>
<script src="../../asset/js/basic.js"></script>
<script src="../../asset/js/basic_admin.js"></script>
</body>
</html>
