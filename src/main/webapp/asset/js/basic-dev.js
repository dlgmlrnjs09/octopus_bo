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

/**
 * 쿼리 스트링 파라미터 셋팅
 */
function setQueryStringParams(formId) {
    if ( !location.search ) {
        return false;
    }

    const form = document.getElementById(formId);

    new URLSearchParams(location.search).forEach((value, key) => {
        if (form[key]) {
            form[key].value = value;
        }
    });
}

function leftPad(value) {
    if (value >= 10) {
        return value;
    }
    return `0${value}`;
}

// Date format [yyyy-MM-dd]
function toStringByFormatting(source, delimiter = '-') {
    const year = source.getFullYear();
    const month = leftPad(source.getMonth() + 1);
    const day = leftPad(source.getDate());

    return [year, month, day].join(delimiter);
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

// chart.js config
const MONTHS = [
    '1월',
    '2월',
    '3월',
    '4월',
    '5월',
    '6월',
    '7월',
    '8월',
    '9월',
    '10월',
    '11월',
    '12월'
];

function months(config) {
    var cfg = config || {};
    var count = cfg.count || 12;
    var section = cfg.section;
    var values = [];
    var i, value;

    for (i = 0; i < count; ++i) {
        value = MONTHS[Math.ceil(i) % 12];
        values.push(value.substring(0, section));
    }

    return values;
}

const CHART_COLORS = {
    red: 'rgb(255, 99, 132)',
    orange: 'rgb(255, 159, 64)',
    yellow: 'rgb(255, 205, 86)',
    green: 'rgb(75, 192, 192)',
    blue: 'rgb(54, 162, 235)',
    purple: 'rgb(153, 102, 255)',
    grey: 'rgb(201, 203, 207)'
};

function transparentize(value, opacity) {
    var Color = Chart.helpers.color;
    var alpha = opacity === undefined ? 0.5 : 1 - opacity;

    return Color(value).alpha(alpha).rgbString();
}

function restartAnims(chart) {
    chart.stop();
    const meta0 = chart.getDatasetMeta(0);
    const meta1 = chart.getDatasetMeta(1);
    for (let i = 0; i < data.length; i++) {
        const ctx0 = meta0.controller.getContext(i);
        const ctx1 = meta1.controller.getContext(i);
        ctx0.xStarted = ctx0.yStarted = false;
        ctx1.xStarted = ctx1.yStarted = false;
    }
    chart.update();
}

const DATA_COUNT = new Date().getMonth() + 1;
const NUMBER_CFG = {count: DATA_COUNT, min: 0, max: 100};

var _seed = Date.now();

function numbers(config) {
    var cfg = config || {};
    var min = cfg.min || 0;
    var max = cfg.max || 100;
    var from = cfg.from || [];
    var count = cfg.count || 8;
    var decimals = cfg.decimals || 8;
    var continuity = cfg.continuity || 1;
    var dfactor = Math.pow(10, decimals) || 0;
    var data = [];
    var i, value;

    for (i = 0; i < count; ++i) {
        value = (from[i] || 0) + this.rand(min, max);
        if (this.rand() <= continuity) {
            data.push(Math.round(dfactor * value) / dfactor);
        } else {
            data.push(null);
        }
    }

    return data;
}

function rand(min, max) {
    min = min || 0;
    max = max || 0;
    _seed = (_seed * 9301 + 49297) % 233280;
    return min + (_seed / 233280) * (max - min);
}