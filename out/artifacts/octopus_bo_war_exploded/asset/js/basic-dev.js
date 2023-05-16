function go_view_detail(seq, url) {
    $("input[name='seq']").val(seq);
    let frm = $("#form");
    frm.attr("action", url);
    frm.attr("method", "get");
    frm.submit();
}