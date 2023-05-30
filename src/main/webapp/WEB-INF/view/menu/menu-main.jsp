<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>메뉴 관리</title>
</head>
<body>
    <script>

        let menuNm = '';
        let menuUrl = '';
        let menuAuthority = '';
        let isUse = '';
        let menuIconUrl = '';

        function selectMenuDetail(menuSeq) {
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
                    $("#menuIconTr").hide();

                    $("#menuNm").val(data[0].menu_nm);
                    $("#menuUrl").val(data[0].menu_url);
                    $("#menuAuthority").val(data[0].has_authority);

                    console.log(data[0].file_path);

                    if(data[0].file_path != '' && data[0].file_path != null) {
                        $("#menuIcon").attr("src", "../../asset/upload/img" + data[0].file_path);
                    }

                    // 사용 여부
                    if(data[0].is_use) {
                        $("input:radio[name='isUse']:radio[value='true']").prop('checked', true);
                    } else {
                        $("input:radio[name='isUse']:radio[value='false']").prop('checked', true);
                    }

                    if(data[0].level == 1) {
                        $("#menuIconTr").show();
                        $("#menuIcon").show();
                    }
                }
            });
        }

        $(document).on("click", ".treeItem", function() {
            let menuSeq = $(this).attr('value');

            $("#menuSeq").val(menuSeq);

            $("a").removeClass("on");
            $(this).addClass("on");

            selectMenuDetail(menuSeq);
        });

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

            //수정 버튼
            $("#modifyBtn").click(function() {
                if(!confirm("수정 하시겠습니까?")) {
                    return false;
                }

                if($("#menuSeq").val() == '') {
                    alert("메뉴를 선택해주세요.");
                    return false;
                }
                if($("#menuNm").val().trim() == '') {
                    alert("메뉴 이름을 작성해주세요.");
                    $("#menuNm").focus();
                    return false;
                }
                // if($("#menuUrl").val().trim() == '') {
                //     alert("메뉴 URL을 작성해주세요.");
                //     $("#menuUrl").focus();
                //     return false;
                // }

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
                if(!confirm("삭제 하시겠습니까?")) {
                    return false;
                }

                if($("#menuSeq").val() == '') {
                    alert("메뉴를 선택해주세요.");
                    return false;
                }

                $.ajax({
                    type : "GET",
                    url : "/menu/delete-menu",
                    dataType:"text",
                    data : $("#menuForm").serialize(),
                    success : function(result){
                        if(result == '1') {
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
                menuAuthority = $("#menuAuthority").val();
                isUse = $("input:radio[name='isUse']:checked").val();
                menuIconUrl = $("#menuIcon").attr('src');

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
                $("#menuAuthority").val('');
                $("input:radio[name='isUse']:radio[value='true']").prop('checked', true);

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
                $("#menuAuthority").val(menuAuthority);
                $("#menuIcon").attr('src', menuIconUrl);

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
                if(!confirm("저장 하시겠습니까?")) {
                    return false;
                }

                if($("#menuSeq").val() == '') {
                    alert("메뉴를 선택해주세요.");
                    return false;
                }
                if($("#menuNm").val().trim() == '') {
                    alert("메뉴 이름을 작성해주세요.");
                    $("#menuNm").focus();
                    return false;
                }
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
    <style>
    /* 컨텐츠 다단 레이아웃 */
    .workingbox {position:relative; clear:both; overflow:hidden; width:100%; margin:20px 0 0; *zoom:1; z-index:1; padding-top: 50px; padding-left: 50px; padding-right: 50px;}
    .workingbox:after {content:''; display:block; clear:both;}
    .workingbox .working_box_l {float:left; width:25%; margin:0; padding:0; *zoom:1; z-index:1;}
    .workingbox .working_box_l:after {content:''; display:block; clear:both;}
    .workingbox .working_box_r {float:right; width:73%; margin:0; padding:0; *zoom:1; z-index:1;}
    .workingbox .working_box_r:after {content:''; display:block; clear:both;}

    .workingboxp {clear:both; overflow:hidden; width:100%; padding:10px 0 0; *zoom:1; z-index:1; }
    .workingboxp:after {content:''; display:block; clear:both;}
    .workingboxp .working_box_l {float:left; width:22%; margin:0; padding:0; *zoom:1; z-index:1;}
    .workingboxp .working_box_l:after {content:''; display:block; clear:both;}
    .workingboxp .working_box_r {float:right; width:75%; margin:0; padding:0; *zoom:1; z-index:1;}
    .workingboxp .working_box_r:after {content:''; display:block; clear:both;}

    .clfix:after {content:"."; display:block; height:0;	clear:both;	visibility:hidden;}
    .clfix {display: inline-block;}
    /* Hides from IE-mac \*/
    * html .clfix {height: 1%;}
    .clfix   {display: block;}

    /* 콘텐츠 트리메뉴 */
    .left_area {*zoom:1; border:1px solid #d2d2d2; height:674px; overflow:hidden; position:relative;}
    .left_area:after {content:''; display:block; clear:both;}
    .left_area .title_area{background:#69649c; padding:13px 0; border-bottom:1px solid #d2d2d2; clear:both; overflow:hidden;}
    .left_area .title_area .tit_h2{font-size:14px; font-weight:bold; color:white; padding-left:12px; padding-top:4px; float:left;}
    .left_area .title_area .btn_area{float:right; padding-right:12px;}
    .left_area .title_area .btn_area button{margin-left:2px; *margin-left:0px;}
    .left_area .btn_area2 {padding:10px 10px 0 0; text-align:right;}
    .left_area .btn_area2 button{margin-left:5px; *margin-left:3px;}

    .right_area {margin-top:20px; *zoom:1; border:1px solid #d2d2d2; height:674px; overflow:hidden; position:relative;}
    .right_area:after {content:''; display:block; clear:both;}
    .right_area .title_area{background:#f0f0f0; padding:13px 0; border-bottom:1px solid #d2d2d2; clear:both; overflow:hidden;}
    .right_area .title_area .tit_h2{font-size:14px; font-weight:bold; color:#333; padding-left:12px !important; padding-top:4px; float:left;}
    .right_area .title_area .btn_area{float:right; padding-right:12px;}
    .right_area .title_area .btn_area button{margin-left:2px; *margin-left:0px;}

    .left_area2 {margin-top:20px; *zoom:1; border:1px solid #d2d2d2; height:674px; overflow:hidden; position:relative;}
    .left_area2:after {content:''; display:block; clear:both;}
    .left_area2 .title_area {position:relative; height:40px; background:#f0f0f0; padding:13px 0; border-bottom:1px solid #d2d2d2; clear:both; overflow:hidden;}
    .left_area2 .title_area:after {content:"";display:block;clear:both;}
    .left_area2 .title_area .tit_h2{margin:0; font-size:15px; font-weight:bold; color:#333; padding-left:12px !important; padding-top:4px;}
    .left_area2 .title_area .btn_area {position:absolute; right:0; bottom:10px; padding-right:12px;}
    .left_area2 .title_area .btn_area button{margin-left:2px; *margin-left:0px;}
    .left_area2 .btn_area2 {padding:10px 10px 0 0; text-align:right;}
    .left_area2 .btn_area2 button{margin-left:5px; *margin-left:3px;}

    .right_area2 {margin-top:20px; *zoom:1; border:1px solid #d2d2d2; height:674px; overflow:hidden; position:relative;}
    .right_area2:after {content:''; display:block; clear:both;}
    .right_area2 .title_area{background:#f0f0f0; padding:13px 0; height:40px; border-bottom:1px solid #d2d2d2; clear:both; overflow:hidden;}
    .right_area2 .title_area .tit_h2{margin:0; font-size:14px; font-weight:bold; color:#333; padding-left:12px !important; padding-top:4px;}
    .right_area2 .title_area .btn_area{float:right; padding-right:12px;}
    .right_area2 .title_area .btn_area button{margin-left:2px; *margin-left:0px;}


    /* tree 메뉴 */
    ul.tree_area{ width:auto; margin:0px 0 0 20px; padding:16px 16px 0 0; clear:both; *zoom:1; overflow:auto; height:610px; position:relative;}
    ul.tree_area:after {content:''; display:block; clear:both;}
    ul.tree_area li{ display:block; margin:0 !important; padding:0; line-height:18px; color:#333; position:relative; clear:both;}
    ul.tree_area li a{color:#333; padding-left:16px;}
    ul.tree_area li a.on{ font-weight:bold; color:#826bcc;}
    ul.tree_area li .f_file{position:absolute; left:0px; top:2px; *top:0px; width:10px; height:11px; cursor:pointer;}
    ul.tree_area li .f_up{position:absolute; left:0px; top:2px; *top:0px; width:11px; height:11px; cursor:pointer;}
    ul.tree_area li .f_dn{position:absolute; left:0px; top:2px; *top:0px; width:11px; height:11px; cursor:pointer;}
    ul.tree_area li .f_up em, ul.tree_area li .f_dn em, ul.tree_area li .f_file em{ display:none; font-size:0; line-height:none;}

    ul.tree_area ul{display:none; margin:0 0 0 17px; padding-top:5px; padding-bottom:9px !important;}
    ul.tree_area ul li{display:block; color:#666; padding:0; line-height:18px; font-weight:normal; position:relative; clear:both;}
    ul.tree_area ul li a{display:inline-block; padding-left:16px; line-height:25px;}
    ul.tree_area ul li a.on{font-weight:bold !important;}
    ul.tree_area ul li a.selected{color:#d82e6f !important; font-weight:normal !important;}
    ul.tree_area ul li .f_up{position:absolute; left:0px; top:2px; *top:0px; width:11px; height:11px; *margin-top:2px; cursor:pointer;}
    ul.tree_area ul li .f_dn{position:absolute; left:0px; top:2px; *top:0px; width:11px; height:11px; *margin-top:2px; cursor:pointer;}
    ul.tree_area ul li .f_up em, ul.tree_area ul li .f_dn em{ display:none; font-size:0; line-height:none;}

    ul.tree_area ul li ul{margin:0 0 0 17px; padding:0px 0 9px;}
    ul.tree_area ul li ul li{display:block; color:#333; line-height:16px; padding:3px 0 1px; font-weight:normal;}
    ul.tree_area ul li ul li a{color:#333; padding-left:16px;}
    ul.tree_area ul li ul li a.selected{color:#d82d6f !important;}
    ul.tree_area ul li ul li .f_file{position:absolute; left:0px; top:5px; *top:3px; width:10px; height:11px; cursor:pointer;}
    ul.tree_area ul li ul li .f_up{position:absolute; left:0px; top:4px; *top:3px; width:11px; height:11px; cursor:pointer;}
    ul.tree_area ul li ul li .f_dn{position:absolute; left:0px; top:4px; *top:3px; width:11px; height:11px; cursor:pointer;}
    ul.tree_area ul li ul li .f_file em, ul.tree_area ul li ul li .f_up em, ul.tree_area ul li ul li .f_dn em{ display:none; font-size:0; line-height:none;}

    .btnR{clear:both;margin:10px 0 0 0;text-align:right;}
    </style>

    <!--========== CONTENTS ==========-->
    <div class="workingbox clfix">
		<div class="working_box_l clfix">
            <section class="section home-sec notice-sec">
                <div class="left_area">
                    <div class="title_area">
                        <h2 class="tit_h2">메뉴 관리</h2>
                    </div>
                    <ul id="treeBasic" class="tree_area">
                    <c:forEach varStatus="status" items="${menuList}" var="menu">

                        <c:set var="hasChild" value="${menu.level < menuList[status.count].level}"/>
                        <c:set var="isEnd" value="${menu.level > menuList[status.count].level}"/>
                        <li>
                        <a class="treeItem" href="#" value="${menu.menu_seq}" data-level="${menu.level}">${menuList[status.index].menu_nm }</a>

                        <c:choose>
                            <c:when test="${hasChild }">
                            <ul style="display: block;">
                            </c:when>
                            <c:otherwise>
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
            <section class="section home-sec notice-sec">
                <div id="divBasicInfo" class="data_cont marT20">
                    <form id="menuForm" name="menuForm" action="" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="menuSeq" name="menuSeq" value="">
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
                                        <div>
                                            <input class="text_e w98p" value="" type="text" id="menuAuthority" name="menuAuthority"/>
                                        </div>
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
                            <button id="modifyBtn" class="custom-btn" type="button" value="modify"><span><span class="size01">수정</span></span></button>
                            <button id="insertBtn" class="custom-btn" type="button" value="insert"><span><span class="size01">하위추가</span></span></button>
                            <button id="deleteBtn" class="custom-btn" type="button" value="delete"><span><span class="size01">삭제</span></span></button>
                        </div>
                        <div id="insertMenuBtnDiv" style="display: none;">
                            <button id="saveBtn" class="custom-btn" type="button" value="save"><span><span class="size01">저장</span></span></button>
    					    <button id="cancelBtn" class="custom-btn" type="button" value="cancel"><span><span class="size01">취소</span></span></button>
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
