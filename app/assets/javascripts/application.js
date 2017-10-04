// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery.ui.widget
//= require z.jquery.fileupload
//= require popper
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree .

function scrollToBottom(){
  if($('#messages').length > 0){
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

$(document).ready(function(){
  scrollToBottom();
});

document.addEventListener("turbolinks:load", function() {

$(function() {
  $('.direct-rec-image-upload').find("input:file").each(function(i, elem) {
    console.log("calling upload function");
    var fileInput    = $(elem);
    var form         = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);

    fileInput.fileupload({
      fileInput:       fileInput,
      url:             form.data('url'),
      type:            'POST',
      autoUpload:       true,
      formData:         form.data('form-data'),
      paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
      replaceFileInput: false,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
      },
      start: function (e) {
        console.log("starting start");
        submitButton.prop('disabled', true);

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
          console.log("finished start");
      },
      done: function(e, data) {
        console.log("starting done");
        submitButton.prop('disabled', false);
        progressBar.text("Uploading done");

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '//' + form.data('host') + '/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
        console.log("finished done");
      },
      fail: function(e, data) {
        console.log("starting fail");
        submitButton.prop('disabled', false);

        progressBar.
          css("background", "red").
          text("Failed");
        console.log("finished fail");
      }
    });
    console.log("finished upload function");
  });
});
});
