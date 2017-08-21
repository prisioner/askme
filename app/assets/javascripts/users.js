// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  // Изменение цвета фона
  $('#user_avatar_bg_color').change(function(){
    $('.user-header').css('background', $(this).val());
  });

  // Изменение цвета рамки
  $('#user_avatar_border_color').change(function(){
    $('.user-image-div').css('border-color', $(this).val());
  });

  // Изменение цвета текста
  $('#user_profile_text_color').change(function(){
    $('.user-header').css('color', $(this).val());
  });

  // Изменение никнейма
  $('#user_username').on('input', function(){
    $('#user_nickname_sandbox').text('@' + $(this).val().toLowerCase());
  });

  // Изменение имени
  $('#user_name').on('input', function(){
    $('#user_name_sandbox').text($(this).val());
  });

  // Сброс цветов
  $('#user_reset_colors').click(function(){
    $('#user_avatar_bg_color').val('#005a55');
    $('.user-header').css('background', '#005a55');

    $('#user_avatar_border_color').val('#00b6ad');
    $('.user-image-div').css('border-color', '#00b6ad');

    $('#user_profile_text_color').val('#ffffff');
    $('.user-header').css('color', '#ffffff');
    return false;
  });
});
