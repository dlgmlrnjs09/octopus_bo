<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <link rel="stylesheet" href="/asset/css/admin/menu-tree.css">
    <link rel="stylesheet" href="../../../asset/css/admin/common.css">
    <link rel="stylesheet" href="../../../asset/css/admin/set_site.css">
    <title>메뉴 관리</title>
</head>
<body>
    <script>

        let menuNm = '';
        let menuUrl = '';
        let isUse = '';
        let menuIconUrl = '';
        let hasAuthority = [];

        function selectMenuDetail(menuSeq) {
            $("input:checkbox[name='select']").prop('checked', false);

            $("#fileIcon").val('');

            $("#insertMenuBtnDiv").hide();
            $("#parentMenuTr").hide();
            $("#defaultBtnDiv").show();

            $.ajax({
                type : "GET",
                url : "/menu/select-menu-detail",
                dataType:"json",
                data : { 'menuSeq' : menuSeq },
                success : function(data){
                    $("#insertBtn").show();
                    $("#modifyBtn").show();
                    $("#deleteBtn").show();
                    $("#menuIconTr").hide();

                    $("#menuNm").val(data[0].menu_nm);
                    $("#menuUrl").val(data[0].menu_url);
                    // $("#hasAuthority").val(data[0].has_authority);
                    let authority = (data[0].has_authority||'').split(",");

                    // 권한 체크박스
                    $("input:checkbox[name='select']").each(function() {
                        for (var i = 0; i < authority.length; i++) {
                            if(authority[i].toUpperCase() == $(this).data("role")) {
                                $(this).prop('checked', true);
                            }
                        }
                    });

                    // 아이콘 경로
                    if(data[0].file_path != '' && data[0].file_path != null) {
                        $("#menuIcon").attr("src", "../../asset/upload/img" + data[0].file_path);
                    }

                    // 사용 여부
                    if(data[0].is_use) {
                        $("input:radio[name='isUse']:radio[value='true']").prop('checked', true);
                    } else {
                        $("input:radio[name='isUse']:radio[value='false']").prop('checked', true);
                    }

                    // 계층별 설정
                    if(data[0].level == 0) {
                        $("#modifyBtn").hide();
                        $("#deleteBtn").hide();
                    }

                    if(data[0].level == 1) {
                        $("#menuIconTr").show();
                        $("#menuIcon").show();
                    }

                    if(data[0].level == 3) {
                        $("#insertBtn").hide();
                    }
                }
            });
        }

        // $(document).on("click", ".treeItem", function() {
        //     let menuSeq = $(this).attr('value');
        //
        //     $("#menuSeq").val(menuSeq);
        //
        //     $("a").removeClass("on");
        //     $(this).addClass("on");
        //
        //     selectMenuDetail(menuSeq);
        // });

        function imageView(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('#menuIcon').attr('src', e.target.result);
                    $('#menuIcon').show();
                }

                reader.readAsDataURL(input.files[0]);
            }
        }

        $(document).ready(function() {

            $(".set-menu-list a").click(function () {
                let menuSeq = $(this).attr('value');
                let menuLevel = $(this).data('level');

                $("#menuSeq").val(menuSeq);

                var link = $(this);
                var closest_ul = link.closest("ul");
                var parallel_active_links = closest_ul.find(".active")
                var closest_li = link.closest("li");
                var link_status = closest_li.hasClass("active");
                var count = 0;

                closest_ul.find("ul").slideUp(function () {
                    if (++count == closest_ul.find("ul").length) {
                        parallel_active_links.removeClass("active");
                        parallel_active_links.children("ul").removeClass("show-dropdown");
                    }
                });

                if (!link_status) {
                    closest_li.children("ul").slideDown().addClass("show-dropdown");
                    closest_li.parent().parent("li.active").find('ul').find("li.active").removeClass("active");
                    link.parent().addClass("active");
                }

                selectMenuDetail(menuSeq);
            })

            //수정 버튼
            $("#modifyBtn").click(function() {
                if($("#menuSeq").val() == '') {
                    alert("메뉴를 선택해주세요.");
                    return false;
                }
                if($("#menuNm").val().trim() == '') {
                    alert("메뉴 이름을 작성해주세요.");
                    $("#menuNm").focus();
                    return false;
                }

                if(!confirm("수정 하시겠습니까?")) {
                    return false;
                }
                // if($("#menuUrl").val().trim() == '') {
                //     alert("메뉴 URL을 작성해주세요.");
                //     $("#menuUrl").focus();
                //     return false;
                // }
                let authorityList = '';
                $("input:checkbox[name='select']").each(function() {
                    if($(this).is(":checked") == true) {
                        authorityList += $(this).attr("id").split("_")[1] + ','
                    }
                });
                authorityList = authorityList.slice(0, -1);

                $("#hasAuthority").val(authorityList);

                var formData = new FormData($('#menuForm')[0]);
                $.ajax({
                    type : "POST",
                    url : "/menu/update-menu",
                    dataType:"text",
                    processData: false,
                    contentType: false,
                    data : formData,
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

            //삭제 버튼
            $("#deleteBtn").click(function() {
                if($("#menuSeq").val() == '') {
                    alert("메뉴를 선택해주세요.");
                    return false;
                }

                if(!confirm("삭제 하시겠습니까? \n*해당 메뉴의 하위 메뉴까지 전부 삭제됩니다.")) {
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/menu/delete-menu",
                    dataType:"text",
                    data : $("#menuForm").serialize(),
                    success : function(result){
                        if(parseInt(result) >= 1) {
                            alert("삭제가 완료되었습니다.");
                           window.location.reload();
                        } else {
                            alert("삭제에 문제가 생겼습니다.");
                        }
                    }
                });
            });

            //하위추가 버튼
            $("#insertBtn").click(function() {
                $("#menuIconTr").hide();

                menuNm = $("#menuNm").val();
                menuUrl = $("#menuUrl").val();
                isUse = $("input:radio[name='isUse']:checked").val();
                menuIconUrl = $("#menuIcon").attr('src');
                hasAuthority = [];

                $("input:checkbox[name='select']").each(function() {
                    if($(this).is(":checked") == true) {
                        hasAuthority.push($(this).attr("id"));
                    }
                });

                if($("#menuSeq").val() == '') {
                    alert("상위 메뉴를 선택해주세요.");
                    return false;
                }
                if($('a[value='+$("#menuSeq").val()+']').data("level") == 0) {
                    $("#menuIconTr").show();
                    $("#menuIcon").hide();
                }

                $("#menuNm").val('');
                $("#menuUrl").val('');
                $("input:radio[name='isUse']:radio[value='true']").prop('checked', true);
                $("input:checkbox[name='select']").prop('checked', false);

                $("#parentMenuNm").text(menuNm);

                $("#insertMenuBtnDiv").show();
                $("#parentMenuTr").show();
                $("#defaultBtnDiv").hide();
            });

            //취소 버튼
            $("#cancelBtn").click(function() {
                $("#menuIconTr").hide();
                $("#fileIcon").val('');

                $("#menuNm").val(menuNm);
                $("#menuUrl").val(menuUrl);
                // $("#hasAuthority").val(hasAuthority);
                $("#menuIcon").attr('src', menuIconUrl);

                $("input:checkbox[name='select']").each(function() {
                    for (var i = 0; i < hasAuthority.length; i++) {
                        if(hasAuthority[i] == $(this).attr("id")) {
                            $(this).prop('checked', true);
                        }
                    }
                });

                if(isUse == 'true') {
                    $("input:radio[name='isUse']:radio[value='true']").prop('checked', true);
                } else {
                    $("input:radio[name='isUse']:radio[value='false']").prop('checked', true);
                }

                if($('a[value='+$("#menuSeq").val()+']').data("level") == 1) {
                    $("#menuIconTr").show();
                }

                $("#insertMenuBtnDiv").hide();
                $("#parentMenuTr").hide();
                $("#defaultBtnDiv").show();
            });

            //저장 버튼
            $("#saveBtn").click(function() {
                if($("#menuSeq").val() == '') {
                    alert("메뉴를 선택해주세요.");
                    return false;
                }
                if($("#menuNm").val().trim() == '') {
                    alert("메뉴 이름을 작성해주세요.");
                    $("#menuNm").focus();
                    return false;
                }

                if(!confirm("저장 하시겠습니까?")) {
                    return false;
                }

                let authorityList = '';
                $("input:checkbox[name='select']").each(function() {
                    if($(this).is(":checked") == true) {
                        authorityList += $(this).attr("id").split("_")[1] + ','
                    }
                });
                authorityList = authorityList.slice(0, -1);

                $("#hasAuthority").val(authorityList);

                // 1 depth 메뉴의 경우 아이콘 이미지 필수 처리
                if($('a[value='+$("#menuSeq").val()+']').data("level") == 0) {
                    if("" == $("#fileIcon").val() || null == $("#fileIcon").val()){
                        alert("이미지를 선택해 주세요!");
                        $("#fileIcon").focus();
                        return false;
                    }

                    var checkExt = true;
                    $("input:file[name^='fileIcon']:visible").each(function(){
                        if("" != $(this).val() && null != $(this).val()){
                            var ext = $(this).val().split('.').pop().toLowerCase();
                            if($.inArray(ext, ['jpg', 'png', 'jpeg']) == -1) {
                                alert('메뉴 아이콘에는 이미지 파일만 등록가능합니다.');
                                checkExt = false;
                            }
                        }
                    });

                    if(!checkExt){
                        return false;
                    }
                }

                var formData = new FormData($('#menuForm')[0]);
                $.ajax({
                    type : "POST",
                    url : "/menu/insert-menu",
                    dataType:"text",
                    processData: false,
                    contentType: false,
                    data : formData,
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
        <div class="home-section-wrap">
            <div>
                <h2 class="sec-title">기본 설정</h2>
                <p class="txt">메뉴 리스트 조회 및 수정</p>
            </div>
        </div>
		<div class="working_box_l clfix">
            <section class="section set-menu-sec">
                <div class="set-menu-list">
                    <ul class="depth1 show-dropdown">
                        <c:forEach varStatus="status" items="${menuList}" var="menu">
                            <c:set var="hasChild" value="${menu.level < menuList[status.count].level}"/>
                            <c:set var="isEnd" value="${menu.level > menuList[status.count].level}"/>
                                <li>
                                    <a href="javascript:;" value="${menu.menu_seq}" data-level="${menu.level}"><span><c:out value="${menuList[status.index].menu_nm }"/></span>
                                <c:choose>
                                    <c:when test="${hasChild && menu.level ne 0}">
                                        <img src="../../../asset/img/admin/icon-arrow-down.svg" alt="down-arrow"></a>
                                        <ul class="depth${menu.level + 1}">
                                    </c:when>
                                    <c:otherwise>
                                        </a>
                                    </li>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${isEnd }">
                                    <c:forEach begin="1" end="${menu.level - menuList[status.count].level }" step="1">
                                        </ul>
                                    </li>
                                    </c:forEach>
                                </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </section>
        </div>
        <div id="divContent" class="working_box_r clfix">
            <section class="section home-sec">
                <div id="divBasicInfo" class="data_cont marT20">
                    <form id="menuForm" name="menuForm" action="" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="menuSeq" name="menuSeq" value="">
                        <input type="hidden" id="hasAuthority" name="hasAuthority" value="">
                        <table summary="메뉴 상세" class="common-table" style="width: 100%;">
                            <caption style="display: none;">메뉴 상세</caption>
                            <colgroup>
                                <col width="18%" /><col width="*" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><em>메뉴 이름</em></th>
                                    <td class="cursor-default" style="border-top: 1px solid #c6c9cc !important;">
                                        <div>
                                            <input class="text_e w98p" value="" type="text" id="menuNm" name="menuNm"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="parentMenuTr" style="display: none;">
                                    <th scope="row"><em>상위 메뉴</em></th>
                                    <td class="cursor-default">
                                        <div>
                                                <span id="parentMenuNm"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><em>메뉴 URL</em></th>
                                    <td class="cursor-default">
                                        <div>
                                            <input class="text_e w98p" value="" type="text" id="menuUrl" name="menuUrl"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="menuIconTr" style="display: none;">
                                    <th scope="row"><em>메뉴 아이콘</em></th>
                                    <td>
                                        <div class="field">
                                            <img id="menuIcon" src="" style="width: 36px; height: 36px; background-color: #69649c82; border-radius:6px;" />
                                            <input type="file" name="fileIcon" id="fileIcon" accept="image/*" style="height: 45px;" onchange="imageView(this)"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><em>메뉴 권한</em></th>
                                    <td class="cursor-default">
                                        <ul class="chkgroup-list" style="display:inline-block;">
                                            <c:forEach var="role" items="${roleList}" varStatus="status">
                                                <li style="display:inline-block; margin-right:5px;">
                                                    <div class="basic-check-box">
                                                        <input type="checkbox" name="select" id="chk_${role.roleSeq}" data-role="${role.roleId}" tabindex="-1" class="chkgroup">
                                                        <label for="chk_${role.roleSeq}" tabindex="0">${role.roleName}</label>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="last" scope="row" style="border-bottom-left-radius: 6px;"><em>사용여부</em></th>
                                    <td class="last cursor-default">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="radio01" name="isUse" value="true" checked>
                                                <label for="radio01"><span>사용</span></label>
                                            </div>
                                            <div class="basic-radio-box">
                                                <input type="radio" id="radio02" name="isUse" value="false">
                                                <label for="radio02"><span>사용안함</span></label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <div class="btnR">
                        <div id="defaultBtnDiv">
                            <button id="modifyBtn" class="common-btn" type="button" value="modify"><span><span class="size01">수정</span></span></button>
                            <button id="insertBtn" class="common-btn" type="button" value="insert"><span><span class="size01">하위추가</span></span></button>
                            <button id="deleteBtn" class="common-btn" type="button" value="delete"><span><span class="size01">삭제</span></span></button>
                        </div>
                        <div id="insertMenuBtnDiv" style="display: none;">
                            <button id="saveBtn" class="common-btn" type="button" value="save"><span><span class="size01">저장</span></span></button>
    					    <button id="cancelBtn" class="common-btn" type="button" value="cancel"><span><span class="size01">취소</span></span></button>
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
