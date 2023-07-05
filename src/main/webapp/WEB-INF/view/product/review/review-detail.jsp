<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<html>
<head>
    <title>리뷰 관리</title>
</head>
<body>
    <script>
        $(document).ready(function() {
            //목록 버튼
            $("#toListBtn").click(function() {
                const queryString = new URLSearchParams(location.search).toString();
                window.location.href = '/product/review/main' + '?' + queryString;
            });
        });
    </script>

    <!--========== CONTENTS ==========-->
    <main id="main" class="page-home">
        <div class="admin-section-wrap">
            <form id="reviewForm" name="reviewForm">
                <div class="home-section-wrap">
                    <section class="section home-sec">
                        <input type="hidden" id="reviewSeq" name="reviewSeq" value="${review.reviewSeq}">
                        <table class="common-table" summary="리뷰상세정보">
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
                                        ${review.regId}
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">회원 이름</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${review.memberNm}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">상품 정보</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${review.productName}
                                        <c:if test="${review.orderOption ne ''}">
                                            <br>
                                            옵션 - ${review.orderOption}
                                        </c:if>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">등록일</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${review.regDt}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">평점</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <fmt:formatNumber value="${review.starPoint}" pattern=".0"/>
                                    </div>
                                </td>
                                <th class="row-th" scope="row"><div class="con-th">추천수</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        ${review.likeCount}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">이미지</div></th>
                                <td class="cell-td dt-left" colspan="4">
                                    <div class="con-td">
                                        <c:forEach var="path" items="${filePathList}" varStatus="status">
                                            <img src="../../asset/upload/img${path}" style="width: 25%; border-radius:6px; margin: 10px 5px 10px 5px;" />
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">내용</div></th>
                                <td class="cell-td dt-left" colspan="4">
                                    <div class="con-td">
                                        <div class="textarea-box">
                                            <textarea style="height: 100px;" readonly>${review.reviewContent}</textarea>
                                            <span class="border-focus"><i></i></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div style="margin-top: 20px; float: right;">
                            <button type="button" id="toListBtn" style="padding: 10px; font-size: 15px; margin-right: 10px;" class="common-btn" aria-label="title"><span>목록</span></button>
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
