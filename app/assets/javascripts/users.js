// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('change', '#user_avatar_bg_color', function(){
  $('.user-header').css('background', $(this).val());
});

$(document).on('change', '#user_avatar_border_color', function(){
  $('.user-image-div').css('border-color', $(this).val());
});

$(document).on('change', '#user_profile_text_color', function(){
  $('.user-header').css('color', $(this).val());
});

$(document).on('input', '#user_username', function(){
  $('#user_nickname_sandbox').text('@' + $(this).val().toLowerCase());
});


$(document).on('input', '#user_name', function(){
  $('#user_name_sandbox').text($(this).val());
});
