function go_view_detail(seq, url) {
    $("input[name='seq']").val(seq);
    let frm = $("#form");
    frm.attr("action", url);
    frm.attr("method", "get");
    frm.submit();
}

function createCkEditor(uploadUrl, callback) {
    ClassicEditor
    .create(document.querySelector('#editor'), {
        ckfinder: {
            uploadUrl : uploadUrl
        }
    })
    .then( newEditor => {
        console.log( 'Editor was initialized', newEditor );
        editor = newEditor;
        return newEditor;
    } )
    .then( editor => {
        window.editor = editor;
        return editor;
    } )
    .catch( error => {
        console.error( 'Oops, something went wrong!' );
        console.error( 'Please, report the following error on https://github.com/ckeditor/ckeditor5/issues with the build id and the error stack trace:' );
        console.warn( 'Build id: g64ljk55ssvc-goqlohse75uw' );
        console.error( error );
    } );
}

function setDefaultDatepicker () {
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
    });
}

function initDatePicker(startSelector, endSelector) {
    setDefaultDatepicker();

    $(startSelector).datepicker({
        onSelect: function () {
            let sDate = new Date($(startSelector).val());
            let eDate = new Date($(endSelector).val());
            if(sDate > eDate) {
                alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
                $(startSelector).val($(endSelector).val());
                return false;
            }
        }
    });
    $(endSelector).datepicker({
        onSelect : function () {
            let sDate = new Date($(startSelector).val());
            let eDate = new Date($(endSelector).val());
            if(sDate > eDate) {
                alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
                $(startSelector).val($(endSelector).val());
                return false;
            }
        }
    });
}

// 검색기간 3개월 제한
function initPrivacyDatePicker(startSelector, endSelector) {
    setDefaultDatepicker();

    $(startSelector).datepicker({
        onSelect: function (selectDate) {
            let sDate = new Date($(startSelector).val());
            let eDate = new Date($(endSelector).val());
            if(sDate > eDate) {
                alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
                $(startSelector).val($(endSelector).val());
                return false;
            }

            let orgEndDate = $(endSelector).val();
            if (orgEndDate !== '' && orgEndDate != null) {
                eDate.setMonth(eDate.getMonth() - 3);
                if (!isSameDate(new Date(selectDate), eDate)) {
                    if (!(new Date(selectDate) >= eDate)) {
                        alert('날짜의 범위는 3개월을 초과할 수 없습니다.');
                        $(startSelector).datepicker('setDate', eDate).datepicker('fill');
                        return false;
                    }
                }
            }
        }
    });
    $(endSelector).datepicker({
        onSelect : function (selectDate) {
            let sDate = new Date($(startSelector).val());
            let eDate = new Date($(endSelector).val());
            if(sDate > eDate) {
                alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
                $(startSelector).val($(endSelector).val());
                return false;
            }

            let orgStartDate = $(startSelector).val();
            if (orgStartDate !== '' && orgStartDate != null) {
                sDate.setMonth(sDate.getMonth() + 3);
                if (!isSameDate(new Date(selectDate), sDate)) {
                    if (!(new Date(selectDate) < sDate)) {
                        alert('날짜의 범위는 3개월을 초과할 수 없습니다.');
                        $(endSelector).datepicker('setDate', sDate);
                        return false;
                    }
                }
            }
        }
    });

    const isSameDate = (date1, date2) => {
        return date1.getFullYear() === date2.getFullYear()
            && date1.getMonth() === date2.getMonth()
            && date1.getDate() === date2.getDate();
    };
}

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
            document.getElementById('zipCode').value = data.zonecode;
            document.getElementById("addr1").value = roadAddr;
            document.getElementById("addrDetail").value = '';
            document.getElementById("addrDetail").focus();

            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("addr2").value = extraRoadAddr.trim();
            } else {
                document.getElementById("addr2").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'inline-block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'inline-block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}