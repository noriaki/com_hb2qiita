// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery
//= require bootstrap-sass-official
//= require jquery-ujs
// require turbolinks
//= require clipboard


// for setting page
;jQuery(function($) {
    var copy_button_selector = '.btn-copy';
    var tooltip_options = {
        trigger: 'manual', placement: 'bottom'
    };
    var clipboard = new Clipboard(copy_button_selector);
    $(copy_button_selector).tooltip(tooltip_options);
    $('.copiable').tooltip(tooltip_options).on('click', function() {
        $(this).tooltip('hide');
    }).on('hidden.bs.tooltip', function() {
        $(this).parent().siblings('.ios-notice').slideUp('fast');
    });
    clipboard.on('success', function(e) {
        $(e.trigger).tooltip('show').delay(2000).queue(function() {
            $(this).tooltip('hide').dequeue();
        });
    }).on('error', function(e) {
        var target = $($(e.trigger).data('clipboard-target'));
        target.get(0).setSelectionRange(0, target.val().length);
        target.tooltip('show');
        target.parent().siblings('.ios-notice').slideDown('slow');
    });
});
