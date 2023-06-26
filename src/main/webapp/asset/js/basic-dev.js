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