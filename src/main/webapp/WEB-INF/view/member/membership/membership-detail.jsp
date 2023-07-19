<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/common_taglib.jsp" %>
<style>
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

    select.init-select {
        padding: 0px 6px;
        min-width: 50px;
    }

</style>

<script>

    function submitData(FLAG) {

        let flagNm = FLAG === 'insert' ? '등록' : FLAG === 'update' ? '수정' : '삭제';
        const formData = new FormData($('#frm')[0]);

        $.ajax({
            url: '/member/membership/submit/' + FLAG,
            type:  'POST',
            data: formData,
            contentType: false,
            processData: false,
            cache:false,
            success: function (data) {
                if (data.result == 'OK') {
                    action_popup.alert2(flagNm + '되었습니다.', function() {
                        location.href = '/member/membership/main';
                    })
                } else {
                    action_popup.alert(data.msg);
                }
            }
        });
    }

    function imageView(element) {
        if(element.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#menuIcon').attr('src', e.target.result);
                $('#menuIcon').show();
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    function numOnly() {
        //TODO 구현

    }

    $(function (){

        //저장
        $('#saveBtn').on('click', function () {

            if ( $('input[name=membershipName]').val().trim() == '') {
                action_popup.alert("등급명을 입력해주세요.");
                return;
            }

            $('.min-amount').each(function () {
               if ($(this).val() == '') $(this).val(0);
            });

            submitData('${flag}');
        });

        //목록
        $('#listBtn').on('click', function () {
            location.href = '/member/membership/main';
        });

        //삭제
        $('#removeBtn').on('click', function () {
            submitData('delete');
        });

        $('input[name=membershipIsAuto]').click(function () {
            if ('${membershipDetail.membership_seq}' == 1) return;

            if ($(this).val() == 'true') {
                $('input[name=membershipAutoAmount]').removeAttr('disabled');
            } else {
                $('input[name=membershipAutoAmount]').attr('disabled', true);
            }
        })

        $('input[name=benefitFlags]').click(function () {
            if ($(this).is(':checked')) {
                $(this).siblings('span').css('visibility', 'visible');
            } else {
                $(this).siblings('span').css('visibility', 'hidden');
            }
        });
    });
</script>

<main id="main" class="page-home">
    <div class="admin-section-wrap">
        <form id="frm" name="frm" method="post" enctype="multipart/form-data">
            <c:choose>
                <c:when test="${not empty membershipDetail.membership_priority}">
                    <c:set var="membershipPriority" value="${membershipDetail.membership_priority}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="membershipPriority" value="${maxMembershipPriority}"/>
                </c:otherwise>
            </c:choose>
            <input type="hidden" name="membershipPriority" value="${membershipPriority}"/>
            <input type="hidden" name="membershipSeq" value="${membershipDetail.membership_seq}"/>

            <div class="home-section-wrap">
                <section class="section home-sec">
                    <table class="common-table" summary="회원등급">
                        <colgroup>
                            <col width="15%">
                            <col width="85%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등급명</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box-wrap">
                                            <div class="input-box text">
                                                <input type="text" name="membershipName" value="${membershipDetail.membership_name}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등급 설명</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box-wrap">
                                            <div class="input-box text">
                                                <input type="text" name="membershipDescription" value="${membershipDetail.membership_description}">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등급 기준</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="radio-box-wrap">
                                            <div class="basic-radio-box">
                                                <input type="radio" id="autoTrue" name="membershipIsAuto" value="true" <c:if test="${membershipDetail.membership_is_auto eq true}">checked</c:if> />
                                                <label for="autoTrue"><span>주문 누적금액</span></label>
                                            </div>
                                            <div class="input-box text" style="width: 10%; display: inline-block">
                                                <input type="text" name="membershipAutoAmount" value="${membershipDetail.membership_auto_amount}" oninput="numOnly();" maxlength="9" <c:if test="${membershipDetail.membership_is_auto ne true or membershipDetail.membership_seq eq 1}">disabled</c:if> style="text-align: right">
                                                <span class="border-focus"><i></i></span>
                                            </div>
                                            <label for="autoTrue"><span>원 이상</span></label>
                                            <c:if test="${membershipDetail.membership_seq ne 1}">
                                                <div class="basic-radio-box" style="display: block">
                                                    <input type="radio" id="autoFalse" name="membershipIsAuto" value="false" <c:if test="${membershipDetail.membership_is_auto eq false or flag eq 'insert'}">checked</c:if> />
                                                    <label for="autoFalse"><span>수동</span></label>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등급 혜택</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="basic-check-box">
                                            <input type="checkbox" name="benefitFlags" id="benefit_discount" value="discount" <c:if test="${fn:contains(membershipDetail.benefit_flag, 'discount')}">checked</c:if> >
                                            <label for="benefit_discount" style="margin-right:5px">할인</label>
                                            <span class="dc_site" <c:if test="${not fn:contains(membershipDetail.benefit_flag, 'discount')}">style="visibility: hidden"</c:if>>
                                                :&nbsp;
                                                <div class="input-box text" style="width: 10%; display: inline-block">
                                                    <input type="text" class="min-amount" name="dcMinAmount" value="${membershipDetail.dc_min_amount}" oninput="numOnly();" maxlength="9" style="text-align: right">
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                원 이상 구매시
                                                <div class="input-box text" style="width: 7%; display: inline-block">
                                                    <input type="number" name="dcRate" value="${membershipDetail.dc_rate}" oninput="numOnly();" maxlength="9" style="text-align: right">
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                <div class="basic-select-box" style="display: inline-block;">
                                                    <select class="init-select" name="dcInit">
                                                        <option value="%" <c:if test="${membershipDetail.dc_init eq '%'}">selected</c:if> >%</option>
                                                        <option value="원" <c:if test="${membershipDetail.dc_init eq '원'}">selected</c:if> >원</option>
                                                    </select>
                                                </div>
                                                할인
                                            </span>
                                        </div>
                                        <div class="basic-check-box">
                                            <input type="checkbox" name="benefitFlags" id="benefit_mileage" value="mileage" <c:if test="${fn:contains(membershipDetail.benefit_flag, 'mileage')}">checked</c:if> >
                                            <label for="benefit_mileage" style="margin-right:5px">적립</label>
                                            <span class="mg_site" <c:if test="${not fn:contains(membershipDetail.benefit_flag, 'mileage')}">style="visibility: hidden"</c:if>>
                                                :&nbsp;
                                                <div class="input-box text" style="width: 10%; display: inline-block">
                                                    <input type="text" class="min-amount" name="mgMinAmount" value="${membershipDetail.mg_min_amount}" oninput="numOnly();" maxlength="9" style="text-align: right">
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                원 이상 구매시
                                                <div class="input-box text" style="width: 7%; display: inline-block">
                                                    <input type="number" name="mgRate" value="${membershipDetail.mg_rate}" oninput="numOnly();" maxlength="9" style="text-align: right">
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                <div class="basic-select-box" style="display: inline-block;">
                                                    <select class="init-select" name="mgInit">
                                                        <option value="%" <c:if test="${membershipDetail.mg_init eq '%'}">selected</c:if> >%</option>
                                                        <option value="원" <c:if test="${membershipDetail.mg_init eq '원'}">selected</c:if> >원</option>
                                                    </select>
                                                </div>
                                                적립
                                            </span>
                                        </div>
                                        <div class="basic-check-box">
                                            <input type="checkbox" name="benefitFlags" id="benefit_delivery" value="delivery" <c:if test="${fn:contains(membershipDetail.benefit_flag, 'delivery')}">checked</c:if> >
                                            <label for="benefit_delivery" style="margin-right:5px">배송비 무료</label>
                                            <span class="dv_site" <c:if test="${not fn:contains(membershipDetail.benefit_flag, 'delivery')}">style="visibility: hidden"</c:if>>
                                                :&nbsp;
                                                <div class="input-box text" style="width: 10%; display: inline-block">
                                                    <input type="text" class="min-amount" name="dvMinAmount" value="${membershipDetail.dv_min_amount}" oninput="numOnly();" maxlength="9" style="text-align: right">
                                                    <span class="border-focus"><i></i></span>
                                                </div>
                                                원 이상 구매시 배송비 무료
                                            </span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="row-th" scope="row"><div class="con-th">등급 아이콘</div></th>
                                <td class="cell-td dt-left">
                                    <div class="con-td">
                                        <div class="input-box text">
                                            <img id="menuIcon" src="../../asset/upload/img${filePath}" style="width: 36px; height: 36px; background-color: #69649c82; border-radius:6px; margin-bottom: 3px;" />
                                            <input style="width: auto; height: 41px;" type="file" name="fileIcon" id="fileIcon" accept="image/*" style="height: 45px;" onchange="imageView(this)"/>
                                        </div>
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