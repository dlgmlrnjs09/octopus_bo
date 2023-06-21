<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>회원 엑셀 등록</title>
</head>
<body>
<script type="text/javascript">

    var excelResult = {};

    $(document).ready(function () {

        //엑셀다운로드 버튼
        $('#btn_excelDownload').click (function () {
            $('#frmDefault').attr ('action', '/file/insertMemberSampleDown').submit();
        });

        var dimmLayerPop3 = function(id, posy, posx){
            var $this =$("#" + id);
            var openThisPop = function (){
                $this.css({visibility : "hidden", position : "absolute"}).show(0,function(){
                    $this.wrap('<div class="modal_window"/>').before('<div class="dimm"/>');
                    repositionThisPop(id);
                });
                $("body, html").addClass("no_scroll");
            };

            var repositionThisPop = function(id){
                var $this = $("#" + id),
                    mgt = $this.height() / 2 * -1,
                    mgl = $this.width() / 2 * -1;

                $this.prev(".dimm").height($(document).height());
                $this.css({top : posy, left : posx, marginTop : mgt, marginLeft  : mgl, visibility : "visible"});
                $this.parent(".modal_window").addClass("modal_window_ie7");
            };
            openThisPop();
            $(window).resize(function(){
                repositionThisPop(id);
            });
            /*parent.setInnerHeight($("body").height() + 300);*/
        };

        var dimmLayerPop = function(id,opt){
            var $this =$("#" + id);
            var closeThisPop = function (){
                $this.hide(0,function(){
                    $this.css({visibility : "visible", position : "relative"});
                }).unwrap().prev(".dimm").remove();
                $("body, html").removeClass("no_scroll");
            };
            var openThisPop = function (){
                var indexCurrent = 1000;
                if($("body").find(".modal_window").length > 0){
                    $("body").find(".modal_window").each(function(index,element){
                        if(($(this).css("z-index")) * 1 > indexCurrent){
                            indexCurrent = 	($(this).css("z-index")) * 1;
                        }
                    });
                    indexCurrent = indexCurrent + 1;
                }
                $this.css({visibility : "hidden", position : "absolute"}).show(0,function(){
                    $this.wrap('<div class="modal_window" style="z-index:'+indexCurrent+'"/>').before('<div class="dimm"/>');
                    repositionThisPop(id);
                });
                $("body, html").addClass("no_scroll");
                $this.find("*").load(function(){
                    repositionThisPop(id);
                });
            };
            if(opt != 0){
                openThisPop();
            }else{
                closeThisPop();
            }
            /*closebtn.click(function(){
                closeThisPop();
                return false;
            });*/
            /*$this.prev(".dimm").click(function(){
                closeThisPop();
            });*/
            $(window).resize(function(){
                repositionThisPop(id);
            });
        };

        //등록 버튼
        $('#btn_submit').bind("click", function () {
            if("" == $("#fileExcel").val() || null == $("#fileExcel").val()){
                alert("엑셀파일을 선택해 주세요!");
                $("#fileExcel").focus();
                return false;
            }

            var checkExt = true;
            $("input:file[name^='fileExcel']:visible").each(function(){
                if("" != $(this).val() && null != $(this).val()){
                    var ext = $(this).val().split('.').pop().toLowerCase();
                    var title = $(this).closest("table").find("caption").text();
                    if($.inArray(ext, ['xls']) == -1) {
                        alert(title + '에는 xls 파일만 등록가능합니다.');
                        checkExt = false;
                    }
                }
            });

            if(!checkExt){
                return false;
            }
            if(confirm("회원을 일괄 등록 하시겠습니까?")){
                var formData = new FormData($('#frmDefault')[0]);
                $.ajax({
                    type : "POST",
                    url : "insert-member-list",
                    processData: false,
                    contentType: false,
                    dataType : "json",
                    data: formData,
                    success : function(result){
                        excelResult = result;
                        var resultMsg;
                        var resultLog;
                        if (result.result) {
                            resultMsg = "총 " + result.totalCnt + "개의 데이터 중 " + result.totalCnt + "개 성공 <span style='color: red;'>(0개 실패)</span>";
                            $("#resultMsg").html(resultMsg);
                            $("#resultLog").html("");
                            window.opener.location.reload();
                            alert("등록이 완료되었습니다");
                            window.open('about:blank','_self').close();
                        }else {
                            resultMsg = "총 " + result.totalCnt + "개의 데이터 중 " + (result.succesCnt) + "개 성공 <span style='color: red;'>("+result.failCnt+"개 실패)</span>";
                            $("#resultMsg").html(resultMsg);
                            $("#resultLog").html("<button type='button' class='common-btn'><a href='javascript:;' style='color:white;'>오류 다운로드</a></button>");
                            $("#resultLog").find("a").on("click", function(e) { logExcelDownlaod(); });
                            alert("회원 일괄 등록 중 오류가 발생하였습니다. \n등록결과 확인 후 실패한 항목 재 등록 바랍니다.");
                        }
                        $("#resultDiv").show();
                    },
                    error : function(request, status, error){
                        alert("잘못된 파일입니다. 다시 확인해 주세요.");
                    },
                    beforeSend : function() {
                        $('.wrap-loading').removeClass('display-none');
                    },
                    complete : function() {
                        $('.wrap-loading').addClass('display-none');
                    }
                });
            }

        });
    });


    /**
     * 로그 파일 엑셀 다운로드
     */
    function logExcelDownlaod () {

        // 엑셀 다운로드시 로딩바 생성함.
        var DOWNLOAD_URL = "excel/insert-member-excel-log";
        var HIDDEN_FRAME_ID = '__hidden_frame_for_file_download__';
        // Validate IFrame.
        var iframe = document.getElementById(HIDDEN_FRAME_ID);
        // IFrame 생성.
        if (!iframe) {
            iframe = document.createElement('iframe');
            iframe.id = iframe.name = HIDDEN_FRAME_ID;
            iframe.style.display = 'none';
            document.body.appendChild(iframe);
        }
        // Build a form. Form 생성
        var cd = iframe.contentDocument;
        $(cd.body).empty();
        var form = cd.createElement('form'); // <form>
        form.action = DOWNLOAD_URL;
        form.method = 'POST';
        form.id = 'excelForm';
        form.acceptCharset = 'UTF-8';

        var data = {
            validateMemberList : excelResult.validateMemberList,
            validateList : excelResult.validateList
        }

        var tteInput = cd.createElement('input'); // <input>
        tteInput.type = 'hidden';
        tteInput.name = 'dataJson';
        tteInput.value = JSON.stringify(data);
        form.appendChild(tteInput); // </input>
        $(cd.body).append(form);
        form.submit();

    }

</script>
<div id="content">
    <div class="search" style="margin-top: 20px;">
        <div class="search_cont">
            <form id="frmDefault" name="default" action="" method="post" enctype="multipart/form-data">
                <p>
                    <span class="txt_red"> * 샘플 양식 다운로드 후 등록하세요. (임의 수정 시 오류 발생)</span>
                    <button class="common-btn" type="button" id="btn_excelDownload" style="margin-left: 10px;"><span>샘플 양식 다운로드</span></button>
                </p>
                <table summary="입력" class="common-table" style="width: 100%;">
                    <caption style="visibility: hidden;">입력</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                        <col width="13%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row" style="border-radius: 0px;"><em>회원 목록(.xls)</em></th>
                        <td colspan="3" style="border-top: 1px solid #c6c9cc;">
                            <div class="field">
                                <input type="file" name="fileExcel" id="fileExcel" accept=".xls" style="height: 45px;" />
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <div class="btnArea">
            <div class="btnC">
                <button id="btn_submit" class="common-btn" type="button">
                    <span><span class="size01">등록</span></span>
                </button>
                <button id="btn_cancel" class="common-btn" type="button" onclick="window.open('about:blank','_self').close();return false;">
                    <span><span class="size01">취소</span></span>
                </button>
            </div>
        </div>

        <div style="margin-top: 28px; display: none;" id="resultDiv">
            <h2 class="dp2_title">등록 결과</h2>
            <div class="notice_board mt10">
                <table class="notice_write">
                    <colgroup>
                        <col style="width:25%"><col style="width:75%">
                    </colgroup>
                    <tbody>
                    <tr style="height: 34px;">
                        <th scope="row">[등록 결과]</th>
                        <hr>
                        <td id="resultMsg"></td>
                    </tr>
                    <tr style="height: 34px;">
                        <th scope="row">로그</th>
                        <td id="resultLog"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="wrap-loading display-none">
    <div><img style="width: 50px;" src="../../asset/img/admin/loading.gif" /></div>
</div>

</body>
</html>
