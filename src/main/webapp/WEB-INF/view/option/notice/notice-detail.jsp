<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<style>
    .ck.ck-editor {
        width: 100%;
        margin: 0 auto;
    }

    .ck-editor__editable {
        height: 30vh;
    }

    .mini {
        background-color: #bbb;
        width: 60px;
        min-width: 60px;
        padding: 5px;
    }

    .mini-del {
        background-color: white;
        width: 17px;
        min-width: 17px;
        padding: 0px;
        height: 17px;
        border: 1px solid #6c6c6c;
        color: #6c6c6c;
    }

    div.exist {
        margin-bottom: 5px;
    }

</style>
<main id="main" class="page-home">
    <div class="admin-section-wrap">
        <form id="frm" name="frm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="pageSize" value="${pageSize}">
            <input type="hidden" name="curPage" value="${curPage}">
            <input type="hidden" name="noticeSeq" value="${noticeDetail.notice_seq}"/>

            <div class="home-section-wrap">
                <section class="section home-sec">
                    <table class="common-table" summary="공지사항">
                        <colgroup>
                            <col width="15%">
                            <col width="85%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">작성자</div></th>
                                <td class="cell-td dt-left"><div class="con-td">${regNm}</div></td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">작성일</div></th>
                                <td class="cell-td dt-left"><div class="con-td">${regDt}</div></td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">제목</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box-wrap">
                                            <c:choose>
                                                <c:when test="${flag eq 'select'}">
                                                    ${noticeDetail.notice_title}
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="input-box text">
                                                        <input type="text" id="noticeTitle" name="noticeTitle" value="${noticeDetail.notice_title}">
                                                        <span class="border-focus"><i></i></span>
                                                    </div>
                                                    <div class="basic-check-box" style="margin-top: 5px;">
                                                        <input type="checkbox" name="isPin" id="isPin" value="1" <c:if test="${noticeDetail.is_pin eq 1}">checked</c:if> >
                                                        <label for="isPin" style="margin-right:5px">상단고정</label>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">첨부파일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="file_list input-box-wrap">
                                            <c:if test="${not empty fileList}">
                                                <div class="exist">
                                                    <c:forEach items="${fileList}" var="fileList">
                                                        <div class="input-box text">
                                                            <span class="file_input">
                                                                <a href="/notice/downloadFile/${fileList.seq}" style="display:inline;" class="exist-files" data-seq="${fileList.seq}">${fileList.file_org_name}</a>
                                                            </span>
                                                            <c:if test="${flag ne 'select'}">
                                                                <button type="button" class="common-btn mini-del" onclick="removeExistFile(this, ${fileList.seq});" class="btns del_btn"><span>X</span></button>
                                                            </c:if>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                            <c:if test="${flag ne 'select'}">
                                                <div class="input-box text file-div" <c:if test="${fn:length(fileList) ge 5}">style="display: none; margin-top:5px;"</c:if> >
                                                    <span class="file_input">
                                                        <input type="text" readonly style="width: 20%;"/>
                                                        <label class="common-btn mini" style="background-color: #8f95e4;"> 첨부파일
                                                            <input type="file" name="files" onchange="selectFile(this);" style="display: none;"/>
                                                        </label>
                                                    </span>
                                                    <button type="button" class="common-btn mini" onclick="removeFile(this);" class="btns del_btn"><span>삭제</span></button>
                                                    <button type="button" class="common-btn mini" onclick="addFile();" class="btns fn_add_btn"><span>파일 추가</span></button>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">내용</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <c:choose>
                                            <c:when test="${flag eq 'select'}">
                                                ${noticeDetail.notice_description}
                                            </c:when>
                                            <c:otherwise>
                                                <label for="editor"></label>
                                                <textarea id="editor" name="noticeDescription">${noticeDetail.notice_description}</textarea>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div style="margin-top: 20px; float: right;">
                        <button type="button" id="listBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>목록</span></button>
                        <c:if test="${flag eq 'insert' or flag eq 'update'}">
                            <button type="button" id="saveBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>저장</span></button>
                        </c:if>
                        <c:if test="${flag eq 'update'}">
                            <button type="button" id="removeBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>삭제</span></button>
                        </c:if>
                    </div>
                </section>
            </div>
        </form>
    </div>
</main>

<script>
    if ('${flag}' != 'select') var editor = createCkEditor('/notice/image');

    function submitData(FLAG) {

        let flagNm = FLAG === 'insert' ? '등록' : FLAG === 'update' ? '수정' : '삭제';
        const formData = new FormData($('#frm')[0]);

        $.ajax({
            url: '/notice/submit/' + FLAG,
            type:  'POST',
            data: formData,
            contentType: false,
            processData: false,
            cache:false,
            success: function (data) {
                if (data.result == 'OK') {
                    action_popup.alert2(flagNm + '되었습니다.', function() {
                        //location.href = '/notice/list';
                        document.frm.action = '/notice/list';
                        document.frm.submit();
                    })
                } else {
                    action_popup.alert(data.popupMsg);
                }
            }
        });
    }

    function selectFile(element) {
        const file = element.files[0];
        const filename = element.closest('.file_input').firstElementChild;
        const fileSize = Math.floor(file.size / 1024 / 1024); //1MB

        //파일선택 창에서 취소 버튼이 클릭된 경우
        if (!file) {
            filename.value = '';
            return false;
        }
        // 파일 크기가 5MB를 초과하는 경우
        if (fileSize > 5) {
            action_popup.noti('5MB이하의 파일로 업로드해주세요.');
            filename.value = '';
            element.value = '';
            return false;
        }
        filename.value = file.name;
    }

    function addFile() {
        if ($('.file_input').length >= 5) {
            action_popup.noti('파일은 5개까지만 첨부 가능합니다.');
            return false;
        }

        const html = $('.file-div').html();
        const fileDiv = document.createElement('div');

        fileDiv.setAttribute('class', 'input-box text file-div');
        fileDiv.innerHTML = html;

        document.querySelector('.file_list').appendChild(fileDiv);
    }

    function removeFile(element) {
        if ($('.file-div > .file_input').length <= 1) {
            const inputs = element.previousElementSibling.querySelectorAll('input');
            inputs.forEach(input => input.value = '');
            return false;
        }

        element.parentElement.remove();
    }

    function removeExistFile(element, seq) {
        $('#frm').append('<input type="hidden" name="removeFiles" value="'+seq+'">');
        $('.file-div').css('display', 'inline');

        if ($('.exist > .input-box').length <= 1) {
            $('.exist').remove();
            return false;
        }

        element.parentElement.remove();
    }

    $(function (){
        //저장
        $('#saveBtn').on('click', function () {

            if ( $('#noticeTitle').val().trim() == '') {
                action_popup.alert("제목을 입력해주세요.");
                return;
            }

            let editorContent = editor.getData();
            $("#editor").text(editorContent);

            submitData('${flag}');
        });

        //목록
        $('#listBtn').on('click', function () {
            // location.href = '/notice/list';
            document.frm.action = '/notice/list';
            document.frm.submit();
        });

        //삭제
        $('#removeBtn').on('click', function () {
            //TODO removeFiles input 만들기
            $('.exist-files').each(function() {
                $('#frm').append('<input type="hidden" name="removeFiles" value="'+$(this).data('seq')+'">');
            });
            submitData('delete');
        });
    });
</script>