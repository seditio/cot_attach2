<!-- BEGIN: MAIN -->
<!DOCTYPE HTML>
<!--
/*
 * jQuery File Upload Plugin Demo 6.9.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
-->
<html lang="en">
<head>
<!-- Force latest IE rendering engine or ChromeFrame if installed -->
<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->
<meta charset="utf-8">
<title>{PHP.L.att_attachments}</title>
<!-- Bootstrap CSS Toolkit styles -->
<link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/bootstrap/css/bootstrap.min.css">
<!-- Bootstrap styles for responsive website layout, supporting different screen sizes -->
<link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/bootstrap/css/bootstrap-responsive.min.css">
<!-- Bootstrap CSS fixes for IE6 -->
<!--[if lt IE 7]><link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/bootstrap/css/bootstrap-ie6.min.css"><![endif]-->
<!-- Bootstrap Image Gallery styles -->
<link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/Bootstrap-Image-Gallery/css/bootstrap-image-gallery.min.css">
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/upload/css/jquery.fileupload-ui.css">
<!-- CSS adjustments for browsers with JavaScript disabled -->
<noscript><link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/upload/css/jquery.fileupload-ui-noscript.css"></noscript>
<!-- Generic page styles -->
<link rel="stylesheet" href="{PHP.cfg.plugins_dir}/attach2/lib/upload/css/style.css">
<!-- Shim to make HTML5 elements usable in older Internet Explorer versions -->
<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>
<body>
<div class="container">
    <!-- The file upload form used as target for the file upload widget -->
    <form id="fileupload" action="{ATTACH_ACTION}" method="POST" enctype="multipart/form-data">
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar">
            <div class="span8">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="icon-plus icon-white"></i>
                    <span>{PHP.L.att_add}</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="icon-upload icon-white"></i>
                    <span>{PHP.L.att_start_upload}</span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="icon-ban-circle icon-white"></i>
                    <span>{PHP.L.att_cancel}</span>
                </button>
                <button type="button" class="btn btn-danger delete">
                    <i class="icon-trash icon-white"></i>
                    <span>{PHP.L.Delete}</span>
                </button>
                <input type="checkbox" class="toggle">
            </div>
            <!-- The global progress information -->
            <div class="span4 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                    <div class="bar" style="width:0%;"></div>
                </div>
                <!-- The extended global progress information -->
                <div class="progress-extended">&nbsp;</div>
            </div>
        </div>
        <!-- The loading indicator is shown during file processing -->
        <div class="fileupload-loading"></div>
        <!-- The table listing the files available for upload/download -->
        <table id="attTable" role="presentation" class="table table-striped"><tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody></table>
    </form>
</div>
<!-- modal-gallery is the modal dialog used for the image gallery -->
<div id="modal-gallery" class="modal modal-gallery hide fade" data-filter=":odd">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">&times;</a>
        <h3 class="modal-title"></h3>
    </div>
    <div class="modal-body"><div class="modal-image"></div></div>
    <div class="modal-footer">
        <a class="btn modal-download" target="_blank">
            <i class="icon-download"></i>
            <span>{PHP.L.Download}</span>
        </a>
        <a class="btn btn-success modal-play modal-slideshow" data-slideshow="5000">
            <i class="icon-play icon-white"></i>
            <span>{PHP.L.att_slideshow}</span>
        </a>
        <a class="btn btn-info modal-prev">
            <i class="icon-arrow-left icon-white"></i>
            <span>{PHP.L.Previous}</span>
        </a>
        <a class="btn btn-primary modal-next">
            <span>{PHP.L.Next}</span>
            <i class="icon-arrow-right icon-white"></i>
        </a>
    </div>
</div>
<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td class="preview"><span class="fade"></span></td>
        <td class="name">
            <span>{%=file.name%}</span>
            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
        </td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
            <td class="start">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-primary">
                    <i class="icon-upload icon-white"></i>
                    {PHP.L.att_start}
                </button>
            {% } %}</td>
        {% } else { %}
            <td>&nbsp;</td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-warning">
                <i class="icon-ban-circle icon-white"></i>
                {PHP.L.Cancel}
            </button>
        {% } %}</td>
        <td>&nbsp;</td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
            <td></td>
            <td class="name">
                <span>{%=file.name%}</span>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else { %}
            <td class="preview">{% if (file.thumbnail_url) { %}
                <a href="{%=file.url%}" title="{%=file.name%}" rel="gallery" download="{%=file.name%}"><img src="{%=file.thumbnail_url%}"></a>
            {% } %}</td>
            <td class="name">
                <a href="{%=file.url%}" title="{%=file.name%}" rel="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a><br>
                <input type="text" name="title" class="att-edit-title" placeholder="{PHP.L.Title}" value="{%= typeof file.title === 'undefined' ? '' : file.title%}" data-id="{%=file.id%}">
                {% if (window.FormData) { %}
                <input type="file" name="replacement" class="att-replace-file" data-id="{%=file.id%}" id="att-file{%=file.id%}">
                {% } %}
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td>&nbsp;</td>
        {% } %}
        <td class="delete">
            <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}"{% if (file.delete_with_credentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                <i class="icon-trash icon-white"></i>
                {PHP.L.Delete}
            </button>
            <input type="checkbox" name="delete" value="1">
        </td>
        <td>
            <button type="button" data-id="{%=file.id%}" class="btn btn-primary att-replace-button" style="display:none">{PHP.L.att_replace}</button>
        </td>
    </tr>
{% } %}
</script>
<script src="js/jquery.min.js"></script>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/upload/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/JavaScript-Templates/tmpl.min.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/Bootstrap-Image-Gallery/js/load-image.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/JavaScript-Canvas-to-Blob/canvas-to-blob.min.js"></script>
<!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="{PHP.cfg.plugins_dir}/attach2/lib/Bootstrap-Image-Gallery/js/bootstrap-image-gallery.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/upload/js/jquery.fileupload.js"></script>
<!-- The File Upload file processing plugin -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/upload/js/jquery.fileupload-fp.js"></script>
<!-- The File Upload user interface plugin -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/upload/js/jquery.fileupload-ui.js"></script>
<!-- The localization script -->
<script src="{PHP.cfg.plugins_dir}/attach2/lib/upload/js/locale.js"></script>
<!-- Cotonti config -->
<script type="text/javascript">
if (attConfig === undefined) {
    var attConfig = {
        area: '{ATTACH_AREA}',
        item: '{ATTACH_ITEM}',
        exts: $.map('{ATTACH_EXTS}'.split(','), $.trim),
        accept: '{ATTACH_ACCEPT}',
        maxsize: '{ATTACH_MAXSIZE}',
        autoUpload: '{ATTACH_AUTOUPLOAD}',
        sequential: '{ATTACH_SEQUENTIAL}'
    };
    var attLang = {
        attachFiles: '{PHP.L.att_attach}',
        cancel: '{PHP.L.Cancel}',
        failure: '{PHP.L.att_err_upload}',
        replace: '{PHP.L.att_replace}'
    };
}
</script>
<!-- Table Drag&Drop plugin for reordering -->
<script type="text/javascript" src="js/jquery.tablednd.min.js"></script>
<!-- The main application script -->
<script src="{PHP.cfg.plugins_dir}/attach2/js/attach2.js"></script>
<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->
<!--[if gte IE 8]><script src="js/cors/jquery.xdr-transport.js"></script><![endif]-->
</body>
</html>
<!-- END: MAIN -->
