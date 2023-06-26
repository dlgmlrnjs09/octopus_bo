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