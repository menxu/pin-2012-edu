try
  KindEditor.ready (K) ->
    editor = K.create '.KindEditor',
      uploadJson : "/kindeditor_upload"
    jQuery(document).on 'form-ready-submit', ->
      editor.sync()
catch e
  pie.log(e)
