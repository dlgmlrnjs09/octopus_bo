<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<style>
</style>
<script>
    $(function (){
        //저장
        $('#saveBtn').on('click', function () {

            if ( $('input[name=title]').val().trim() == '') {
                action_popup.alert("제목을 입력해주세요.");
                return;
            }
            if ( $('textarea[name=description]').val().trim() == '') {
                action_popup.alert("내용을 입력해주세요.");
                return;
            }
            const formData = new FormData($('#frm')[0]);

            $.ajax({
                url: '/product/inquiry/submit/' + '${flag}',
                type:  'POST',
                data: $('#frm').serialize(),
                success: function (data) {
                    if (data.result == 'OK') {
                        action_popup.alert2('저장되었습니다.', function() {
                            document.frm.action = '<c:url value="/product/inquiry/list"/>';
                            document.frm.method = 'get';
                            document.frm.submit();
                        })
                    } else {
                        action_popup.alert('처리에 실패했습니다.');
                    }
                }
            });
        });

        //목록
        $('#listBtn').on('click', function () {
            document.frm.action = '<c:url value="/product/inquiry/list"/>';
            document.frm.method = 'get';
            document.frm.submit();
        });

    });
</script>

<main id="main" class="page-home">
    <div class="admin-section-wrap">
        <form id="frm" name="frm" method="post">
            <!--페이징 & 검색조건 유지 -->
            <input type="hidden" name="pageSize" value="${pageSize}">
            <input type="hidden" name="curPage" value="${curPage}">
            <input type="hidden" name="startDate" value="${startDate}">
            <input type="hidden" name="endDate" value="${endDate}">
            <input type="hidden" name="searchKeyword" value="${searchKeyword}">
            <input type="hidden" name="searchType" value="${searchType}">
            <input type="hidden" name="hasAnswer" value="${hasAnswer}">

            <input type="hidden" name="productSeq" value="${data[0].product_seq}"/>
            <input type="hidden" name="parentSeq" value="${data[0].inquiry_seq}"/>
            <input type="hidden" name="inquirySeq" value="${data[1].inquiry_seq}"/>

            <div class="home-section-wrap">
                <!-- 질문 -->
                <section class="section home-sec">
                    <div class="common-table-top">
                    <div class="left-wrap">
                        <h3 class="table-title">질문</h3>
                    </div>
                </div>
                    <table class="common-table" summary="상품문의">
                        <colgroup>
                            <col width="10%">
                            <col width="40%">
                            <col width="10%">
                            <col width="40%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th class="row-th" scope="row">
                                <div class="con-th">상품명</div>
                            </th>
                            <td class="cell-td dt-left">
                                <div class="con-td">${data[0].product_name}</div>
                            </td>
                            <th class="row-th" scope="row">
                                <div class="con-th">구분</div>
                            </th>
                            <td class="cell-td dt-left">
                                <c:choose>
                                    <c:when test="${data[0].inquiry_flag eq 'delivery'}"><c:set var="flagNm" value="배송문의"/></c:when>
                                    <c:when test="${data[0].inquiry_flag eq 'product'}"><c:set var="flagNm" value="상품문의"/></c:when>
                                    <c:when test="${data[0].inquiry_flag eq 'warehousing'}"><c:set var="flagNm" value="입고문의"/></c:when>
                                    <c:when test="${data[0].inquiry_flag eq 'order'}"><c:set var="flagNm" value="주문/결제/취소"/></c:when>
                                    <c:when test="${data[0].inquiry_flag eq 'return'}"><c:set var="flagNm" value="반품/교환/환불"/></c:when>
                                    <c:when test="${data[0].inquiry_flag eq 'other'}"><c:set var="flagNm" value="기타"/></c:when>
                                    <c:otherwise><c:set var="flag_nm" value="기타"/></c:otherwise>
                                </c:choose>
                                <div class="con-td">${flagNm}</div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row">
                                <div class="con-th">작성자</div>
                            </th>
                            <td class="cell-td dt-left">
                                <div class="con-td">${data[0].reg_id}</div>
                            </td>
                            <th class="row-th" scope="row">
                                <div class="con-th">등록일시</div>
                            </th>
                            <td class="cell-td dt-left">
                                <div class="con-td">${data[0].reg_dt_char}</div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row">
                                <div class="con-th">제목</div>
                            </th>
                            <td class="cell-td dt-left" colspan="3">
                                <div class="con-td">${data[0].title}</div>
                            </td>
                        </tr>
                        <tr>
                            <th class="row-th" scope="row">
                                <div class="con-th">내용</div>
                            </th>
                            <td class="cell-td dt-left" colspan="3">
                                <div class="con-td">${data[0].description}</div>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <!--답변-->
                    <div class="common-table-top" style="margin-top: 10px">
                        <div class="left-wrap">
                            <h3 class="table-title">답변</h3>
                        </div>
                    </div>
                    <!--데이터 셋팅-->
                    <table class="common-table" summary="상품문의답변">
                        <colgroup>
                            <col width="10%">
                            <col width="40%">
                            <col width="10%">
                            <col width="40%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="row-th" scope="row">
                                    <div class="con-th">작성자</div>
                                </th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <c:choose>
                                                <c:when test="${fn:length(data) > 1}">
                                                    <input type="text" name="id" value="${data[1].reg_id}" readonly/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" name="id" value="${sessionId}" readonly/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </td>
                                <th class="row-th" scope="row">
                                    <div class="con-th">등록일시</div>
                                </th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" value="${data[1].reg_dt_char}" readonly placeholder="자동 입력"/>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row">
                                    <div class="con-th">제목</div>
                                </th>
                                <td class="cell-td dt-left" colspan="3">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <input type="text" name="title" value="${data[1].title}">
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row">
                                    <div class="con-th">내용</div>
                                </th>
                                <td class="cell-td dt-left" colspan="3">
                                    <div class="con-td">
                                        <div class="textarea-box">
                                            <textarea name="description" rows="10">${data[1].description}</textarea>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- 하단 버튼 -->
                    <div style="margin-top: 20px; float: right;">
                        <button type="button" id="listBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>목록</span></button>
                        <button type="button" id="saveBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>저장</span></button>
                    </div>
                </section>
            </div>
        </form>
    </div>
</main>